//
//  Untitled.swift
//  Assignment_Challenge
//
//  Created by t2025-m0143 on 3/12/26.
//
import RxSwift
import Foundation

final class HomeViewModel: ViewModel {
    struct Input {
        let fetchData: Observable<Void>
        let searchText: Observable<String>
        let playMusic: Observable<MusicCollectionView.Item?>
    }
    
    struct Output {
        let spring: Observable<[Music]>
        let summer: Observable<[Music]>
        let autumn: Observable<[Music]>
        let winter: Observable<[Music]>
        
        let tvShow: Observable<[TvShow]>
        let podcast: Observable<[Podcast]>
        
        let musicPreviewTarget: Observable<Result<(isNew: Bool, music: Music), Error>>
    }
    
    func transform(_ input: Input) -> Output {
        // Music
        let fetchData = input.fetchData.share()
        
        let spring = fetchData
            .withUnretained(self)
            .flatMap { `self`, _ in
                self.fetchMusic(of: .spring)
            }
        
        let summer = fetchData
            .withUnretained(self)
            .flatMap { `self`, _ in
                self.fetchMusic(of: .summer)
            }
        
        let autumn = fetchData
            .withUnretained(self)
            .flatMap { `self`, _ in
                self.fetchMusic(of: .autumn)
            }
        
        let winter = fetchData
            .withUnretained(self)
            .flatMap { `self`, _ in
                self.fetchMusic(of: .winter)
            }
        
        // TVShow, Podcast
        let searchText = input.searchText.share()
        
        let tvShow = searchText
            .withUnretained(self)
            .flatMapLatest { `self`, term in
                self.searchTvShow(with: term)
            }
        
        let podcast = searchText
            .withUnretained(self)
            .flatMapLatest { `self`, term in
                self.searchPodcast(with: term)
            }

        // previewMusic
        let target: Observable<Result<(isNew: Bool, music: Music), Error>> = input.playMusic
            .withUnretained(self) // self를 가져오는데 강한 참조는 x, self가 없으면 flatMap 연산 x
            .flatMap { `self`, item in
                self.fetchPreviewTarget(item: item)
                    .map {
                        .success($0)
                    }
                    .catch {
                        .just(.failure($0))
                    }
            }
        
        return Output(
            spring: spring,
            summer: summer,
            autumn: autumn,
            winter: winter,
            tvShow: tvShow,
            podcast: podcast,
            musicPreviewTarget: target
            )
    }
    
    enum TargetError: Error, AlertableError {
        case invalidTarget
        
        func title() -> String {
            "Target Error"
        }
        
        func message() -> String {
            switch self {
            case .invalidTarget:
                "대상이 유효하지 않습니다."
            }
        }
    }
    
    private let networkService: NetworkService
    private var currentPreview: Music?
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
}

extension HomeViewModel {
    private func fetchPreviewTarget(item: MusicCollectionView.Item?) -> Observable<(isNew: Bool, music: Music)> {
        Observable.create { [weak self] observer in
            guard let self else { return Disposables.create() }
            switch item {
            case .spring(let music):
                if self.currentPreview == music { // 현재 재생중인 곡과 동일한 곡이 선택되었을 경우
                    
                    guard let preview = currentPreview else { return Disposables.create() }
                    
                    observer.on(.next((false, preview)))
                    observer.on(.completed)
                    
                } else { // 다른 곡이 선택되었을 경우
                    currentPreview = music // 현재 재생중인 곡 변경
                    
                    guard let preview = currentPreview else { return Disposables.create() }
                    
                    observer.on(.next((true, preview)))
                    observer.on(.completed)
                }
                
            default:
                observer.onError(TargetError.invalidTarget)
            }
            
            return Disposables.create()
        }
    }
}

enum MediaType {
    case music
    case podcast
    case tvShow
}

extension HomeViewModel {
    private func convert(response: [Media], to media: MediaType) -> [MediaEntity] {
        return response.map {
            let type = determineType(of: $0)
            
            switch type {
            case.music:
                return Music(
                    trackId: $0.trackId,
                    title: $0.title,
                    artist: $0.artist,
                    collection: $0.collection,
                    artworkUrl: $0.artworkUrl60,
                    previewUrl: $0.previewUrl
                )
                
            case .podcast:
                return Podcast(
                    trackId: $0.trackId,
                    title: $0.title,
                    artist: $0.artist,
                    collection: $0.collection,
                    artworkUrl: $0.artworkUrl600 ?? $0.artworkUrl100,
                    previewUrl: $0.previewUrl,
                    feedUrl: $0.feedUrl
                )
                
            case .tvShow:
                return TvShow(
                    trackId: $0.trackId,
                    title: $0.title,
                    artist: $0.artist,
                    collection: $0.collection,
                    artworkUrl: $0.artworkUrl600 ?? $0.artworkUrl100,
                    previewUrl: $0.previewUrl,
                    shortDescription: $0.shortDescription,
                    longDescription: $0.longDescription
                )
            }
        }
    }
    
    private func determineType(of media: Media) -> MediaType {
        return switch media.kind {
        case "music", "song": .music
        case "podcast": .podcast
        default: .tvShow
        }
    }
    
    private func fetchMusic(of season: MusicCollectionView.Section) -> Observable<[Music]> {
        let response: Observable<Response> =
        season == .spring ?
        networkService.searchData(endpoint: ITunesEndpoint.music(season: season, limit: 5))
        : networkService.searchData(endpoint: ITunesEndpoint.music(season: season))
        
        return response
            .withUnretained(self)
            .map { `self`, response in
                let musics = self.convert(response: response.results, to: .music)
                guard let musics = musics as? [Music] else { return [] }
                return musics
        }
    }
    
    private func searchPodcast(with text: String) -> Observable<[Podcast]> {
        let response: Observable<Response> = networkService.searchData(endpoint: ITunesEndpoint.podcast(term: text))
        
        return response
            .withUnretained(self)
            .map { `self`, response in
                let podcasts = self.convert(response: response.results, to: .podcast)
                guard let podcasts = podcasts as? [Podcast] else { return [] }
                return podcasts
            }
    }
    
    private func searchTvShow(with text: String) -> Observable<[TvShow]> {
        let response: Observable<Response> = networkService.searchData(endpoint: ITunesEndpoint.podcast(term: text))
        
        return response
            .withUnretained(self)
            .map { `self`, response in
                let tvShows = self.convert(response: response.results, to: .tvShow)
                guard let tvShows = tvShows as? [TvShow] else { return [] }
                return tvShows
            }
    }
}
