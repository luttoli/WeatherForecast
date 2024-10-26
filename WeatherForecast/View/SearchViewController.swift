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
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.searchBarStyle = .minimal
        searchBar.sizeToFit()
        return searchBar
    }()
    
    private let cityListTableView: UITableView = {
        let cityListTableView = UITableView(frame: .zero, style: .plain)
        cityListTableView.register(CityListCell.self, forCellReuseIdentifier: CityListCell.identifier)
        cityListTableView.backgroundColor = .clear
        cityListTableView.tableFooterView = UIView(frame: .zero)
        cityListTableView.sectionFooterHeight = 0
        cityListTableView.showsVerticalScrollIndicator = false
        cityListTableView.separatorStyle = .none
        return cityListTableView
    }()
    
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
        
        view.backgroundColor = .background.white
        
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
        view.addSubview(searchBar)
        view.addSubview(cityListTableView)
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(Constants.margin.vertical)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.horizontal)
        }
        searchBar.delegate = self
        
        cityListTableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(Constants.margin.vertical)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.horizontal)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.vertical)
        }
        cityListTableView.delegate = self
        cityListTableView.dataSource = self
    }
}

// MARK: - Method
private extension SearchViewController {
    
}

// MARK: - Delegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
}

// MARK: - TableViewDelegate
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityListCell.identifier, for: indexPath) as? CityListCell else { return UITableViewCell() }
        
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        
        cell.configure()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.size.size80
    }
}
