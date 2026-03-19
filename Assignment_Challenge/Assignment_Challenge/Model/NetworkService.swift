//
//  NetworkService.swift
//  Assignment_Challenge
//
//  Created by t2025-m0143 on 3/13/26.
//
import Alamofire
import Foundation
import RxSwift

extension Alamofire.AFError: AlertableError { }

enum NetworkError: Error, AlertableError {
    case invalidURL
    case failedToFetchData
    case emptyData
    
    func title() -> String {
        return "Network Error"
    }
    
    func message() -> String {
        switch self {
        case .invalidURL: "유효하지 않은 URL입니다."
        case .failedToFetchData: "데이터를 가져오는 데 실패하였습니다."
        case .emptyData: "빈 데이터입니다."
        }
    }
}

final class NetworkService {
    private let baseURL = URL(string: "https://itunes.apple.com/search?")
    
    private func searchData<T: Codable>(url: URL, parameters: [String: Any]) async throws -> T {
        let publisher = AF.request(url, method: .get, parameters: parameters)
            .validate()
            .serializingDecodable(T.self)
        
        switch await publisher.result {
        case .success(let response):
            return response
        case .failure(let error):
            throw error
        }
    }
    
    // 음악 정보
    fileprivate func fetchMusic(of section: MusicCollectionView.Section) async throws -> [Music] {
        let query: (term: String, limit: Int) = switch section {
        case .spring:
            (term: "봄", limit: 5)
        default:
            (term: section.title, limit: 12)
        }

        let parameters: [String: Any] = [
            "term": query.term,
            "country": "KR",
            "limit": "\(query.limit)",
            "media": "music"
        ]

        guard let url = baseURL else { throw NetworkError.invalidURL }
        
        let response: MusicResponse = try await searchData(url: url, parameters: parameters)
        return response.results
    }
    
    // 팟캐스트 검색
    fileprivate func searchPodcast(with text: String) async throws -> [Podcast] {
        
        guard let url = baseURL else { throw NetworkError.invalidURL }
        
        let parameters: [String: Any] = [
            "term": text,
            "country": "KR",
            "limit": "5",
            "media": "podcast"
        ]
        
        let response: PodcastResponse = try await searchData(url: url, parameters: parameters)
        return response.results
    }
    
    // tvShow 검색
    fileprivate func searchTvShow(with text: String) async throws -> [TvShow] {
    
        guard let url = baseURL else { throw NetworkError.invalidURL }
        
        let parameters: [String: Any] = [
            "term": text,
            "country": "KR",
            "limit": "5",
            "media": "tvShow"
        ]
        
        let response: TvShowResponse = try await searchData(url: url, parameters: parameters)
        return response.results
    }
}

extension NetworkService: ReactiveCompatible { }

extension Reactive where Base: NetworkService {
    func fetchMusic(of section: MusicCollectionView.Section) -> Single<[Music]> {
        Single.create { [base] observer in
            let task = Task {
                do {
                    let result = try await base.fetchMusic(of: section)
                    observer(.success(result))
                } catch {
                    observer(.failure(error))
                }
            }
            
            return Disposables.create {
                task.cancel() // 구독이 dispose될 때 진행중인 task를 cancel
            }
        }
    }
    
    func searchPodcast(with text: String) -> Observable<[Podcast]> {
        Observable.create { [base] observer in
            let task = Task {
                do {
                    let result = try await base.searchPodcast(with: text)
                    observer.on(.next(result))
                    observer.on(.completed)
                } catch {
                    observer.on(.error(error))
                }
            }
            
            return Disposables.create {
                task.cancel() // 구독이 dispose될 때 진행중인 task를 cancel
            }
        }
    }
    
    func searchTvShow(with text: String) -> Observable<[TvShow]> {
        Observable.create { [base] observer in
            let task = Task {
                do {
                    let result = try await base.searchTvShow(with: text)
                    observer.on(.next(result))
                    observer.on(.completed)
                } catch {
                    observer.on(.error(error))
                }
            }
            
            return Disposables.create {
                task.cancel() // 구독이 dispose될 때 진행중인 task를 cancel
            }
        }
    }
}


