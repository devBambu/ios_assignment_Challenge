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
    func searchData<T: Codable>(endpoint: APIEndpoint) -> Observable<T> {
        let publisher = AF.request(endpoint.baseURL, parameters: endpoint.parameters)
            .validate()
            .serializingDecodable(T.self)
        
        return Observable.create { observer in
            let task = Task {
                switch await publisher.result {
                case .success(let response):
                    observer.on(.next(response))
                    observer.onCompleted()
                    
                case .failure(let error):
                    observer.on(.error(error))
                }
            }
            
            return Disposables.create {
                task.cancel()
                publisher.cancel()
            }
        }
    }
}
