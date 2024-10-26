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
        let weatherTableView = UITableView(frame: .zero, style: .plain)
        weatherTableView.register(CurrentWeatherInfoCell.self, forCellReuseIdentifier: CurrentWeatherInfoCell.identifier)
        weatherTableView.register(TemperatureCell.self, forCellReuseIdentifier: TemperatureCell.identifier)
        weatherTableView.register(FiveDaysCell.self, forCellReuseIdentifier: FiveDaysCell.identifier)
        weatherTableView.register(CityLocationCell.self, forCellReuseIdentifier: CityLocationCell.identifier)
        weatherTableView.register(OtherAverageCell.self, forCellReuseIdentifier: OtherAverageCell.identifier)
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
            $0.top.equalTo(view.safeAreaLayoutGuide)
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
        searchBar.resignFirstResponder()
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
        headerView.backgroundColor = .systemBlue
        
        headerView.layer.cornerRadius = Constants.radius.px12
        headerView.layer.masksToBounds = true
        headerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        let headerLabel = CustomLabel(title: "", size: Constants.size.size15, weight: .light, color: .text.black)
        let separator = CustomSeparator(height: 1)
        
        if section == 1 {
            headerLabel.text = "시간별 일기예보"
        } else if section == 2 {
            headerLabel.text = "5일간의 일기예보"
        } else if section == 3 {
            headerLabel.text = "강수량"
        }
        
        headerView.addSubview(headerLabel)
        headerView.addSubview(separator)
        
        headerLabel.snp.makeConstraints {
            $0.centerY.equalTo(headerView)
            $0.leading.equalTo(headerView).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(headerView).offset(-Constants.margin.horizontal)
        }
        
        if section == 3 {
            separator.isHidden = true
        } else {
            separator.snp.makeConstraints {
                $0.leading.equalTo(headerView).offset(Constants.margin.horizontal)
                $0.trailing.equalTo(headerView).offset(-Constants.margin.horizontal)
                $0.bottom.equalTo(headerView)
            }
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else if section == 4 {
            return 0
        } else {
            return Constants.size.size40
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2 {
            return 5
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrentWeatherInfoCell.identifier, for: indexPath) as? CurrentWeatherInfoCell else { return UITableViewCell() }
            
            cell.selectionStyle = .none
            
            cell.configure()
            
            return cell
        } else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TemperatureCell.identifier, for: indexPath) as? TemperatureCell else { return UITableViewCell() }
            
            cell.backgroundColor = .systemBlue
            cell.selectionStyle = .none
            
            cell.layer.cornerRadius = Constants.radius.px12
            cell.layer.masksToBounds = true
            cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            
            return cell
        } else if indexPath.section == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FiveDaysCell.identifier, for: indexPath) as? FiveDaysCell else { return UITableViewCell() }
            
            cell.backgroundColor = .systemBlue
            cell.selectionStyle = .none
            
            if indexPath.row == 4 {
                cell.layer.cornerRadius = Constants.radius.px12
                cell.layer.masksToBounds = true
                cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            } else {
                cell.layer.cornerRadius = 0
            }
            
            cell.configure()
            
            return cell
        } else if indexPath.section == 3 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CityLocationCell.identifier, for: indexPath) as? CityLocationCell else { return UITableViewCell() }
            
            cell.backgroundColor = .systemBlue
            cell.selectionStyle = .none
            
            cell.layer.cornerRadius = Constants.radius.px12
            cell.layer.masksToBounds = true
            cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            
            return cell
        } else if indexPath.section == 4 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OtherAverageCell.identifier, for: indexPath) as? OtherAverageCell else { return UITableViewCell() }
            
            cell.backgroundColor = .clear
            cell.selectionStyle = .none

            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 260
        } else if indexPath.section == 1 {
            return 100
        } else if indexPath.section == 2 {
            return 50
        } else if indexPath.section == 3 {
            let width = tableView.frame.width - (Constants.margin.horizontal * 2)
            return width
        } else if indexPath.section == 4 {
            let width = tableView.frame.width
            return width
        }
        return CGFloat()
    }
}
