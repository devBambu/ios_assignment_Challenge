//
//  MusicResponse.swift
//  Assignment_Challenge
//
//  Created by t2025-m0143 on 3/13/26.
//

nonisolated
struct Response: Codable {
    let results: [Media]
}

nonisolated
struct Media: Codable, Hashable {
    // 공통
    var trackId: Int
    var kind: String
    
    var title: String
    var artist: String
    var collection: String? = nil
    
    var previewUrl: String? = nil
    
    var artworkUrl600: String? = nil // 아트 사이즈 600
    var artworkUrl100: String? = nil // 아트 사이즈 100
    var artworkUrl60: String? = nil // 앨범 아트 사이즈 60
    
    // podcast
    var feedUrl: String? = nil
    
    // tvShow
    var shortDescription: String? = nil
    var longDescription: String? = nil
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(trackId)
    }
    
    enum CodingKeys: String, CodingKey {
        case trackId
        case kind
        
        case title = "trackName"
        case artist = "artistName"
        case collection = "collectionName"
        
        case previewUrl
        
        case artworkUrl600
        case artworkUrl100
        case artworkUrl60
        
        case feedUrl
        
        case shortDescription
        case longDescription
    }
}
