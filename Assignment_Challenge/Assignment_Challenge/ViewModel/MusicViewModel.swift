//
//  Untitled.swift
//  Assignment_Challenge
//
//  Created by t2025-m0143 on 3/12/26.
//
import RxSwift

final class MusicViewModel: ViewModel {
    struct Input {
        let viewDidload: Observable<Void>
    }
    
    struct Output {
        let musics: Single<[[Item]]>
    }
    
    func transform(_ input: Input) -> Output {
        let musics = Single<[[Item]]>.create { observer in
            let task = Task { [weak self] in
                guard let self else { return }
                do {
                    let spring = try await self.networkService.searchMusic(of: .spring).map { Item.spring($0) }
                    let summer = try await self.networkService.searchMusic(of: .summer).map { Item.summer($0) }
                    let autumn = try await self.networkService.searchMusic(of: .autumn).map { Item.autumn($0) }
                    let winter = try await self.networkService.searchMusic(of: .winter).map { Item.winter($0) }
                    
                    observer(.success([spring, summer, autumn, winter]))
                } catch {
                    observer(.failure(error))
                }
            }
            
            return Disposables.create() {
                task.cancel() // 구독이 dispose될 때 진행중인 task를 cancel
            }
        }
        
        return Output(
            musics: musics
            )
    }
    
    let networkService = NetworkService()
}
