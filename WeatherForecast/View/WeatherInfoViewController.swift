//
//  WeatherInfoViewController.swift
//  WeatherForecast
//
//  Created by 김지훈 on 10/25/24.
//

import UIKit

import SnapKit

class WeatherInfoViewController: UIViewController {
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
extension WeatherInfoViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background.white
        
        navigationUI()
        setUp()
    }
}

// MARK: - Navigation
extension WeatherInfoViewController {
    func navigationUI() {
        navigationController?.navigationBar.barTintColor = .background.white
        
        let searchBar: UISearchBar = {
            let searchBar = UISearchBar()
            searchBar.placeholder = "Search"
            searchBar.searchBarStyle = .minimal
            searchBar.sizeToFit()
            searchBar.delegate = self
            return searchBar
        }()

        navigationItem.titleView = searchBar
    }
}

// MARK: - SetUp
private extension WeatherInfoViewController {
    func setUp() {
        
    }
}

// MARK: - Method
private extension WeatherInfoViewController {

}

// MARK: - Delegate
extension WeatherInfoViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        let searchVC = SearchViewController()
        searchVC.modalPresentationStyle = .fullScreen
        present(searchVC, animated: true, completion: nil)
    }
}
