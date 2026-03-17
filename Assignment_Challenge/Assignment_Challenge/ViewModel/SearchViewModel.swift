//
//  SearchViewModel.swift
//  Assignment_Challenge
//
//  Created by t2025-m0143 on 3/17/26.
//
import Foundation
import RxSwift
import RxRelay

final class SearchViewModel: ViewModel {
    struct Input {
        let searchText: Observable<String>
    }
    
    struct Output {
        let tvShow: Observable<[TvShow]>
    }
    
    private let disposeBag = DisposeBag()
    
    func transform(_ input: Input) -> Output {
        let tvShow = input.searchText
            .debug("search tvShow")
            .flatMap { [networkService] in
                networkService.rx.searchTvShow(with: $0)
            }
            .share()

        
        return Output(tvShow: tvShow)
    }
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    private let networkService: NetworkService

}
