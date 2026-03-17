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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        print("result view loaded")
    }
}

extension ResultViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let text = searchController.searchBar.searchTextField.text
        Task {
            do {
                let response = try await NetworkService().searchTvShow(with: text ?? "")
                print(response)
            } catch {
                print(error)
            }
        }
    }
    
    
}
