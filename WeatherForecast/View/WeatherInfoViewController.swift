//
//  WeatherInfoViewController.swift
//  WeatherForecast
//
//  Created by 김지훈 on 10/25/24.
//

import UIKit

import RxSwift
import SnapKit

class WeatherInfoViewController: UIViewController, SearchViewControllerDelegate {
    // MARK: - Properties
    private let viewModel = WeatherViewModel()
    private let disposeBag = DisposeBag()
    private var weatherData: [Weather] = []
    
    // MARK: - Components
    private let weatherTableView: UITableView = {
        let weatherTableView = UITableView(frame: .zero, style: .plain)
        weatherTableView.register(CurrentWeatherInfoCell.self, forCellReuseIdentifier: CurrentWeatherInfoCell.identifier)
        weatherTableView.register(TemperatureCell.self, forCellReuseIdentifier: TemperatureCell.identifier)
        weatherTableView.register(FiveDaysCell.self, forCellReuseIdentifier: FiveDaysCell.identifier)
        weatherTableView.register(CityLocationCell.self, forCellReuseIdentifier: CityLocationCell.identifier)
        weatherTableView.register(OtherAverageCell.self, forCellReuseIdentifier: OtherAverageCell.identifier)
        weatherTableView.backgroundColor = .clear
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
        bindViewModel()
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
extension WeatherInfoViewController {
    private func bindViewModel() {
        viewModel.weather
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] weatherData in
                self?.weatherData = weatherData
                self?.weatherTableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    func didSelectLocation(lat: Double, lon: Double) {
        viewModel.updateLocation(lat: lat, lon: lon)
    }
}

// MARK: - Delegate
extension WeatherInfoViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        let searchVC = SearchViewController()
        searchVC.modalPresentationStyle = .formSheet
        searchVC.delegate = self
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
        
        let headerLabel = CustomLabel(title: "", size: Constants.size.size15, weight: .light, color: .text.white)
        let separator = CustomSeparator(height: 1)
        
        headerView.addSubview(headerLabel)
        headerView.addSubview(separator)
        
        switch section {
        case 1:
            headerLabel.text = "시간별 일기예보"
        case 2:
            headerLabel.text = "5일간의 일기예보"
        case 3:
            headerLabel.text = "강수량"
            separator.isHidden = true
        default:
            break
        }
        
        headerLabel.snp.makeConstraints {
            $0.centerY.equalTo(headerView)
            $0.leading.equalTo(headerView).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(headerView).offset(-Constants.margin.horizontal)
        }
        
        separator.snp.makeConstraints {
            $0.leading.equalTo(headerView).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(headerView).offset(-Constants.margin.horizontal)
            $0.bottom.equalTo(headerView)
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0, 4:
            return 0
        default:
            return Constants.size.size40
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 2:
            return 5
        default :
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrentWeatherInfoCell.identifier, for: indexPath) as? CurrentWeatherInfoCell else { return UITableViewCell() }
            
            cell.selectionStyle = .none
            
            if let weather = weatherData.first {
                cell.configure(with: weather)
            }
            
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TemperatureCell.identifier, for: indexPath) as? TemperatureCell else { return UITableViewCell() }
            
            cell.backgroundColor = .systemBlue
            cell.selectionStyle = .none
            
            cell.layer.cornerRadius = Constants.radius.px12
            cell.layer.masksToBounds = true
            cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            
            cell.configure(with: weatherData)
            
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FiveDaysCell.identifier, for: indexPath) as? FiveDaysCell else { return UITableViewCell() }
            
            cell.backgroundColor = .systemBlue
            cell.selectionStyle = .none
            
            if indexPath.row == 4 {
                cell.layer.cornerRadius = Constants.radius.px12
                cell.layer.masksToBounds = true
                cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
                cell.separator.isHidden = true
            } else {
                cell.layer.cornerRadius = 0
                cell.separator.isHidden = false
            }
            
            if let weather = weatherData.first {
                cell.configure(with: weather, dayOffset: indexPath.row)
            }
            
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CityLocationCell.identifier, for: indexPath) as? CityLocationCell else { return UITableViewCell() }
            
            cell.backgroundColor = .systemBlue
            cell.selectionStyle = .none
            
            cell.layer.cornerRadius = Constants.radius.px12
            cell.layer.masksToBounds = true
            cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            
            if let weather = weatherData.first {
                cell.updateMapLocation(latitude: weather.city?.coord?.lat ?? 0, longitude: weather.city?.coord?.lon ?? 0, title: weather.city?.name ?? "")
            }
            
            return cell
        case 4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OtherAverageCell.identifier, for: indexPath) as? OtherAverageCell else { return UITableViewCell() }
            
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            
            cell.configure(with: weatherData)

            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return Constants.size.size250
        case 1:
            return Constants.size.size100
        case 2:
            return Constants.size.size50
        case 3:
            let width = tableView.frame.width - (Constants.margin.horizontal * 2)
            return width
        default:
            let width = tableView.frame.width
            return width
        }
    }
}
