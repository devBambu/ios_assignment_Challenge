//
//  HomeView.swift
//  Assignment_Challenge
//
//  Created by t2025-m0143 on 3/11/26.
//

import UIKit
import SnapKit

enum Section: Int {
    case spring
    case summer
    case autumn
    case winter
}

final class HomeCollectionView: UICollectionView {
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        collectionViewLayout = makeCompositionalLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeCollectionView {
    private func makeCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.interSectionSpacing = 20
        
        return UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, environment in
            switch Section(rawValue: sectionIndex) {
            case .spring:
                let containerSize = environment.container.effectiveContentSize
                
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .fractionalHeight(1)
                    )
                )
                
                let group = NSCollectionLayoutGroup(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .absolute(containerSize.width * 0.8),
                        heightDimension: .fractionalWidth(0.6)
                    ))
                
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = containerSize.width * 0.08
                section.orthogonalScrollingBehavior = .groupPaging
                
                return section
                
            default:
                let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
                let section = NSCollectionLayoutSection.list(using: configuration, layoutEnvironment: environment)
                return section
            }
        }, configuration: configuration)
    }
}
