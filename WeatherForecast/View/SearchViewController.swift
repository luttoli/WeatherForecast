//
//  SearchViewController.swift
//  WeatherForecast
//
//  Created by 김지훈 on 10/25/24.
//

import UIKit

import SnapKit

class SearchViewController: UIViewController {
    // MARK: - Properties
    
    
    // MARK: - Components
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - LifeCycle
extension SearchViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
        navigationUI()
        setUp()
    }
}

// MARK: - Navigation
extension SearchViewController {
    func navigationUI() {
        navigationController?.navigationBar.barTintColor = .background.white
        
        
    }
}

// MARK: - SetUp
private extension SearchViewController {
    func setUp() {
        
    }
}

// MARK: - Method
private extension SearchViewController {
    
}

// MARK: - Delegate
extension SearchViewController {
    
}

