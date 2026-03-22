//
//  API Endpoint.swift
//  Assignment_Challenge
//
//  Created by t2025-m0143 on 3/21/26.
//

import Foundation

protocol APIEndpoint {
    var baseURL: URL { get }
    var parameters: [String: String] { get }
}

enum ITunesEndpoint {
    case music(season: MusicCollectionView.Section, limit: Int = 12)
    case tvShow(term: String, limit: Int = 20)
    case podcast(term: String, limit: Int = 20)
}

extension ITunesEndpoint: APIEndpoint {
    var baseURL: URL {
        guard let url = URL(string: "https://itunes.apple.com/search?") else {
            fatalError("invalid URL")
        }
        return url
    }
    
    var parameters: [String : String] {
        var params: [String: String] = [:]
        
        switch self {
        case .music(season: let section, limit: let limit):
            params["term"] = section.title
            params["country"] = "KR"
            params["limit"] = "\(limit)"
            params["media"] = "music"
            
        case .tvShow(term: let term, limit: let limit):
            params["term"] = term
            params["limit"] = "\(limit)"
            params["media"] = "tvShow"
            
        case .podcast(term: let term, limit: let limit):
            params["term"] = term
            params["country"] = "KR"
            params["limit"] = "\(limit)"
            params["media"] = "podcast"
        }
        
        return params
    }
}
