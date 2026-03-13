//
//  HomeView.swift
//  Assignment_Challenge
//
//  Created by t2025-m0143 on 3/13/26.
//
import UIKit
import SnapKit

final class HomeView: UIView {
    private let collectionView = MusicCollectionView()
    private lazy var dataSource = makeCollectionViewDiffableDataSource(collectionView)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeView {
    private func setLayout() {
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}

//MARK: CollectionView
extension HomeView {
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
    
    
    func setSnapshot(with data: [Music]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Music>()
        snapshot.appendSections([.spring])
        snapshot.appendItems(data, toSection: .spring)
        dataSource.apply(snapshot)
    }
}
