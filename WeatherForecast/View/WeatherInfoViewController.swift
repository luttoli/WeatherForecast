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
    private let weatherTableView: UITableView = {
        let weatherTableView = UITableView(frame: .zero, style: .grouped)
        weatherTableView.register(CurrentWeatherInfoCell.self, forCellReuseIdentifier: CurrentWeatherInfoCell.identifier)
        weatherTableView.backgroundColor = .clear
        weatherTableView.tableFooterView = UIView(frame: .zero)
        weatherTableView.sectionFooterHeight = 0
        weatherTableView.showsVerticalScrollIndicator = false
        weatherTableView.separatorStyle = .none
        return weatherTableView
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
        view.addSubview(weatherTableView)
        
        weatherTableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(Constants.margin.vertical)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.horizontal)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.vertical)
        }
        weatherTableView.delegate = self
        weatherTableView.dataSource = self
    }
}

// MARK: - Method
private extension WeatherInfoViewController {

}

// MARK: - Delegate
extension WeatherInfoViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        let searchVC = SearchViewController()
        searchVC.modalPresentationStyle = .formSheet
        present(searchVC, animated: true, completion: nil)
    }
}

// MARK: - TableViewDelegate
extension WeatherInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        
        let headerLabel = CustomLabel(title: "", size: Constants.size.size15, weight: .Regular, color: .text.black)
        
        if section == 1 {
            headerLabel.text = "돌풍의 풍속은 최대 m/s입니다."
        } else if section == 2 {
            headerLabel.text = "5일간의 일기예보"
        } else if section == 3 {
            headerLabel.text = "강수량"
        }
        
        headerView.addSubview(headerLabel)
        headerLabel.snp.makeConstraints {
            $0.centerY.equalTo(headerView)
            $0.leading.equalTo(headerView).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(headerView).offset(-Constants.margin.horizontal)
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrentWeatherInfoCell.identifier, for: indexPath) as? CurrentWeatherInfoCell else { return UITableViewCell() }
            
            cell.configure()
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 260
        } else {
            return 100
        }
    }
}
