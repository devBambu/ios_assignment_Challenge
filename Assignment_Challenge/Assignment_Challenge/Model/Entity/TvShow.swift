//
//  TvShow.swift
//  Assignment_Challenge
//
//  Created by t2025-m0143 on 3/17/26.
//

struct TvShow: Hashable, MediaEntity {
    var trackId: Int
    
    var title: String // 에피소드 이름
    var artist: String // 출연진
    var collection: String? // Tv 시리즈 이름
    
    var artworkUrl: String? = nil // 아트워크
    var previewUrl: String? = nil // 프리뷰
    
    var shortDescription: String?
    var longDescription: String?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(trackId)
    }
}
