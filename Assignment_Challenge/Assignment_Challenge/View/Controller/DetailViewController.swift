//
//  DetailViewController.swift
//  Assignment_Challenge
//
//  Created by t2025-m0143 on 3/22/26.
//
import UIKit

final class DetailViewController: UIViewController {

    let item: ResultCollectionView.Item
    
    init(item: ResultCollectionView.Item) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch item {
        case .podcast(let podcast):
            print(podcast.title)
        case .tvShow(let tvShow):
            print(tvShow.title)
        }
    }
}
