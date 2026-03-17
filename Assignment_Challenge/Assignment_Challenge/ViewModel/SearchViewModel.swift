//
//  SearchViewModel.swift
//  Assignment_Challenge
//
//  Created by t2025-m0143 on 3/17/26.
//
import RxSwift

final class SearchViewModel: ViewModel {
    struct Input {
        let searchText: Observable<String>
    }
    
    struct Output {
        let tvShow: Observable<[TvShow]>
    }
    
    func transform(_ input: Input) -> Output {
        let tvShow = input.searchText
            .flatMap { [networkService] in
                networkService.rx.searchTvShow(with: $0)
            }
        
        return Output(tvShow: tvShow)
    }
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    let networkService: NetworkService
}
