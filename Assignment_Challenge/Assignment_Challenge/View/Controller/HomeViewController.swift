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

    let disposeBag = DisposeBag()
    
    let viewModel = MusicViewModel()
    
    private let searchController = UISearchController(searchResultsController: nil)
    private let collectionView = MusicCollectionView()

    private lazy var dataSource = makeCollectionViewDiffableDataSource(collectionView)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        self.title = "Music"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        navigationItem.preferredSearchBarPlacement = .stacked
        
        setLayout()
        setSnapshot()
    }
    
    private func setLayout() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func bindCollectionData() {

    }
}

extension HomeViewController {
    private func makeCollectionViewDiffableDataSource(_ collectionView: UICollectionView) -> UICollectionViewDiffableDataSource<Section, Music> {
        let headerRegistration = UICollectionView.SupplementaryRegistration<MusicHeaderView>(elementKind: "HeaderKind") { supplementaryView, elementKind, indexPath in
            supplementaryView.configure(with: Section(rawValue: indexPath.section) ?? Section.spring)
        }
        
        let cellRegistration = UICollectionView.CellRegistration<BestMusicCell, Music> { cell, indexPath, music in
            cell.configure(with: music)
        }
        
        let dataSource = UICollectionViewDiffableDataSource<Section, Music>(collectionView: collectionView) { collectionView, indexPath, music in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: music)
        }
        
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
        }
        
        return dataSource
    }
    
    
    private func setSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Music>()
        snapshot.appendSections([.spring])
        snapshot.appendItems(viewModel.musics, toSection: .spring)
        dataSource.apply(snapshot)
    }
}
