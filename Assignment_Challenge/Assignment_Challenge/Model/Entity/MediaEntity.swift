//
//  MediaEntity.swift
//  Assignment_Challenge
//
//  Created by t2025-m0143 on 3/22/26.
//

protocol MediaEntity {
    var trackId: Int { get }
    
    var title: String { get }
    var artist: String { get }
    
    var collection: String? { get }
    var previewUrl: String? { get }
    var artworkUrl: String? { get }
}
