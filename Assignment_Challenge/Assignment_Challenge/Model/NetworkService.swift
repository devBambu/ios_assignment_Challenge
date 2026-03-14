//
//  NetworkService.swift
//  Assignment_Challenge
//
//  Created by t2025-m0143 on 3/13/26.
//
import Alamofire
import Foundation

final class NetworkService {
    func searchData<T: Codable>(url: URL) async throws -> T {
        let publisher = AF.request(url, method: .get)
            .validate()
            .serializingDecodable(T.self)
        
        switch await publisher.result {
        case .success(let response):
            return response
        case .failure(let error):
            throw error
        }
    }
    
    
}
