//
//  ViewController.swift
//  Assignment_Challenge
//
//  Created by t2025-m0143 on 3/11/26.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa


class HomeViewController: UIViewController {

    weak var coordinator: AppCoordinator?
    let viewModel: MusicViewModel
    
    let disposeBag = DisposeBag()
    let homeView = HomeView()
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func loadView() {
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationController()
        bind(viewModel: viewModel)
    }
    
    //MARK: init
    init(viewModel: MusicViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: bind
    private func bind(viewModel: MusicViewModel) {
                
        let output = viewModel.fetchMusics()
        
        output.musics
            .subscribe(onSuccess: { [weak self] in
                self?.homeView.setSnapshot(with: $0)
            }, onFailure: {
                print("\($0)")
            })
            .disposed(by: disposeBag)
    }
}

extension HomeViewController {
    private func setNavigationController() {
        self.title = "Music"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        navigationItem.preferredSearchBarPlacement = .stacked
    }
}
