//
//  Podcast.swift
//  Assignment_Challenge
//
//  Created by t2025-m0143 on 3/17/26.
//

nonisolated
struct Podcast: Hashable, MediaEntity {
    var trackId: Int
    
    var title: String // 팟캐스트 이름
    var artist: String // 아티스트
    
    var collection: String?
    
    var artworkUrl: String? = nil // 아트워크
    var previewUrl: String? = nil // 프리뷰
    
    var feedUrl: String? // 피드 상세내역
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(trackId)
    }
}
