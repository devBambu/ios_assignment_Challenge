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
    
    private let viewModel: SearchViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("result view loaded")
    }
    
    //MARK: init
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: bind
    private func bind() {
        
    }
}

extension ResultViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let text = searchController.searchBar.searchTextField.text
    }
    
    
}
