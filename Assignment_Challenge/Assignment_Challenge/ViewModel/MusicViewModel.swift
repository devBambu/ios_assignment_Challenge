//
//  Untitled.swift
//  Assignment_Challenge
//
//  Created by t2025-m0143 on 3/12/26.
//
import RxSwift

final class MusicViewModel {
    
    struct Output {
        let musics: Single<[Music]>
    }
    
    func fetchMusics() -> Output {
        let data: [Music] = [
            Music(trackId: 1001, title: "Blinding Lights", artist: "The Weeknd", collection: "After Hours"),
            Music(trackId: 1002, title: "Shape of You", artist: "Ed Sheeran", collection: "÷ (Divide)"),
            Music(trackId: 1003, title: "Hype Boy", artist: "NewJeans", collection: "NewJeans 1st EP"),
            Music(trackId: 1004, title: "Bad Guy", artist: "Billie Eilish", collection: "When We All Fall Asleep, Where Do We Go?"),
            Music(trackId: 1005, title: "Dynamite", artist: "BTS", collection: "Dynamite (Single)")
        ]
        
        let musics = Single<[Music]>.create { observer in
            observer(.success(data))
            return Disposables.create()
        }
        
        return Output(musics: musics)
    }
}
