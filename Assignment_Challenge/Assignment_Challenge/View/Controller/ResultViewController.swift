//
//  ResultViewController.swift
//  Assignment_Challenge
//
//  Created by t2025-m0143 on 3/17/26.
//
import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class ResultViewController: UIViewController {
    
    private let viewModel: HomeViewModel
    private let disposeBag = DisposeBag()
    private let resultView = ResultView()
    
    private let searchKeyword: Observable<String>
    
    override func loadView() {
        view = resultView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    //MARK: init
    init(viewModel: HomeViewModel, searchKeyword: Observable<String>) {
        self.viewModel = viewModel
        self.searchKeyword = searchKeyword
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: bind
    private func bind() {
        let input = HomeViewModel.Input(
            fetchData: .empty(),
            searchText: searchKeyword
        )
        
        let output = viewModel.transform(input)
        
        let podcast = output.podcast
            .map { podcasts in
                podcasts.map {
                    ResultCollectionView.Item.podcast($0)
                }
            }
            .share()
        
        let tvShow = output.tvShow
            .map { tvShows in
                tvShows.map {
                    ResultCollectionView.Item.tvShow($0)
                }
            }
            .share()
        
        // 컬렉션뷰 바인딩
        Observable
            .merge(podcast, tvShow)
            .subscribe(
                onNext: { [resultView] in
                    resultView.setSnapshot(with: $0)
                },
                onError: { [weak self] error in
                    print(error)
                })
            .disposed(by: disposeBag)
    }

}

