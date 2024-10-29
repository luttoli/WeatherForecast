//
//  SearchViewController.swift
//  WeatherForecast
//
//  Created by 김지훈 on 10/25/24.
//

import UIKit

import RxSwift
import SnapKit

protocol SearchViewControllerDelegate: AnyObject {
    func didSelectLocation(lat: Double, lon: Double)
}

class SearchViewController: UIViewController {
    // MARK: - Properties
    private let viewModel = SearchViewModel()
    private let disposeBag = DisposeBag()
    private var cities: [CityList] = []
    private var filteredCities: [CityList] = []
    
    weak var delegate: SearchViewControllerDelegate?
    
    // MARK: - Components
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.searchBarStyle = .minimal
        searchBar.sizeToFit()
        return searchBar
    }()
    
    let cityListTableView: UITableView = {
        let cityListTableView = UITableView(frame: .zero, style: .plain)
        cityListTableView.register(CityListCell.self, forCellReuseIdentifier: CityListCell.identifier)
        cityListTableView.backgroundColor = .clear
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
        bindViewModel()
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
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.spacing.px10)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.spacing.px10)
        }
        searchBar.delegate = self
        
        cityListTableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(Constants.margin.vertical)
            $0.leading.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.vertical)
        }
        cityListTableView.delegate = self
        cityListTableView.dataSource = self
    }
}

// MARK: - Method
private extension SearchViewController {
    private func bindViewModel() {
        viewModel.cities
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] cities in
                self?.cities = cities
                self?.filteredCities = cities
                self?.cityListTableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Delegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredCities = cities
        } else {
            filteredCities = cities.filter { city in
                return city.name.lowercased().contains(searchText.lowercased())
            }
        }
        cityListTableView.reloadData()
    }
}

// MARK: - TableViewDelegate
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityListCell.identifier, for: indexPath) as? CityListCell else { return UITableViewCell() }
        
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        
        let city = filteredCities[indexPath.row]

        cell.configure(with: city)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.size.size80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCity = filteredCities[indexPath.row]
        let weatherInfoVC = WeatherInfoViewController()
        
        weatherInfoVC.updateLocation(lat: selectedCity.coord.lat, lon: selectedCity.coord.lon) //
        
        delegate?.didSelectLocation(lat: selectedCity.coord.lat, lon: selectedCity.coord.lon)

        self.dismiss(animated: true) {
            self.navigationController?.pushViewController(weatherInfoVC, animated: true)
        }
    }
}
