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
    
    var title: String {
        switch self {
        case .spring: "봄 Best"
        case .summer: "여름"
        case .autumn: "가을"
        case .winter: "겨울"
        }
    }
    
    var secondaryTitle: String {
        switch self {
        case .spring: "봄에 어울리는 음악 Best 5"
        case .summer: "여름에 어울리는 음악"
        case .autumn: "가을에 어울리는 음악"
        case .winter: "겨울에 어울리는 음악"
        }
    }
}

final class MusicCollectionView: UICollectionView {
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: UICollectionViewLayout())
        collectionViewLayout = makeCompositionalLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MusicCollectionView {
    private func makeCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.interSectionSpacing = 20
        
        return UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, environment in
            
            let headerItem = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(54)
                ),
                elementKind: "HeaderKind",
                alignment: .top
            )
            
            switch Section(rawValue: sectionIndex) {
            case .spring:
                let containerSize = environment.container.effectiveContentSize
                
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .fractionalHeight(1)
                    )
                )
                
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .absolute(containerSize.width * 0.8),
                        heightDimension: .fractionalWidth(0.6)
                    ),
                    subitems: [item]
                )
                
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = containerSize.width * 0.05
                section.orthogonalScrollingBehavior = .groupPagingCentered
                section.boundarySupplementaryItems = [headerItem]
                
                return section
                
            default:
                let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
                let section = NSCollectionLayoutSection.list(using: configuration, layoutEnvironment: environment)
                return section
            }
        }, configuration: configuration)
    }
}
