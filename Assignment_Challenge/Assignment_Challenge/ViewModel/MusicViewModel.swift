//
//  Untitled.swift
//  Assignment_Challenge
//
//  Created by t2025-m0143 on 3/12/26.
//
import RxSwift

final class MusicViewModel: ViewModel {
    struct Input {
        let fetchData: Observable<Void>
//        let searchText: Observable<String>
    }
    
    struct Output {
        let spring: Observable<[Music]>
        let summer: Observable<[Music]>
        let autumn: Observable<[Music]>
        let winter: Observable<[Music]>
        
//        let tvShow: Observable<[TvShow]>
//        let podcast: Observable<[Podcast]>
    }
    
    func transform(_ input: Input) -> Output {
        let spring = input.fetchData
            .flatMap { [networkService] in
                networkService.rx.fetchMusic(of: .spring)
            }
        
        let summer = input.fetchData
            .flatMap { [networkService] in
                networkService.rx.fetchMusic(of: .summer)
            }
        
        let autumn = input.fetchData
            .flatMap { [networkService] in
                networkService.rx.fetchMusic(of: .autumn)
            }
        
        let winter = input.fetchData
            .flatMap { [networkService] in
                networkService.rx.fetchMusic(of: .winter)
            }
        
//        let tvShow = input.searchText
//            .flatMap { [networkService] in
//                networkService.rx.searchTvShow(with: $0)
//            }
//        
//        let podcast = input.searchText
//            .flatMap { [networkService] in
//                networkService.rx.searchPodcast(with: $0)
//            }

        return Output(
            spring: spring,
            summer: summer,
            autumn: autumn,
            winter: winter,
//            tvShow: tvShow,
//            podcast: podcast
            )
    }
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
}
