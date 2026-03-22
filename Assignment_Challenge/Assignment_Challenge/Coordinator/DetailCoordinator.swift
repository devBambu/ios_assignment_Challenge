//
//  DetailCoordinator.swift
//  Assignment_Challenge
//
//  Created by t2025-m0143 on 3/22/26.
//

import UIKit

class DetailCoordinator: Coordinator {
    weak var parentCoordinator: (any Coordinator)?
    
    var children: [any Coordinator] = []
    
    var navigationController: UINavigationController
    
    let item: ResultCollectionView.Item
    
    init(parentCoordinator: (any Coordinator)? = nil, children: [any Coordinator], navigationController: UINavigationController, item: ResultCollectionView.Item) {
        self.parentCoordinator = parentCoordinator
        self.children = children
        self.navigationController = navigationController
        self.item = item
    }
    
    func start() {
        let detailVC = DetailViewController(item: item)
        navigationController.pushViewController(detailVC, animated: true)
    }
}
