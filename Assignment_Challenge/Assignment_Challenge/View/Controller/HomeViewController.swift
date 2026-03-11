//
//  ViewController.swift
//  Assignment_Challenge
//
//  Created by t2025-m0143 on 3/11/26.
//

import UIKit

class HomeViewController: UIViewController {

    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        self.title = "Music"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        navigationItem.preferredSearchBarPlacement = .stacked
    }


}

