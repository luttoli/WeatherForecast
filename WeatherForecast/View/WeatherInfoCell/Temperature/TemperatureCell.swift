//
//  TemperatureCell.swift
//  WeatherForecast
//
//  Created by 김지훈 on 10/26/24.
//

import UIKit

import RxSwift
import SnapKit

class TemperatureCell: UITableViewCell {
    // MARK: - Properties
    private let viewModel = WeatherViewModel()
    private let disposeBag = DisposeBag()
    private var weatherData: [Weather] = []
    private var weatherList: [List] = []
    
    // MARK: - Components
    let temperatureCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let temperatureCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        temperatureCollectionView.register(TimeTemperatureCell.self, forCellWithReuseIdentifier: TimeTemperatureCell.identifier)
        temperatureCollectionView.backgroundColor = .clear
        temperatureCollectionView.showsHorizontalScrollIndicator = false
        return temperatureCollectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        temperatureCollectionView.reloadData()
    }
}

// MARK: - SetUp
private extension TemperatureCell {
    func setUp() {
        contentView.addSubview(temperatureCollectionView)
        
        temperatureCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        temperatureCollectionView.delegate = self
        temperatureCollectionView.dataSource = self
    }
}

// MARK: - Method
extension TemperatureCell {
    private func updateUpcomingWeatherList() {
        guard let weather = weatherData.first, let weatherList = weather.list else { return }
        
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "Asia/Seoul")
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        
        let closestIndex = weatherList.enumerated().min { (item1, item2) in
            guard let date1 = dateFormatter.date(from: item1.element.dtTxt ?? ""),
                  let date2 = dateFormatter.date(from: item2.element.dtTxt ?? "") else {
                return false
            }
            return abs(date1.timeIntervalSince(now)) < abs(date2.timeIntervalSince(now))
        }?.offset ?? 0

        self.weatherList = Array(weatherList[closestIndex..<min(closestIndex + 16, weatherList.count)])
    }
    
    func configure(with weatherData: [Weather]) {
        self.weatherData = weatherData
        updateUpcomingWeatherList()
        temperatureCollectionView.reloadData()
    }
}

// MARK: - CollectionViewDelegate
extension TemperatureCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimeTemperatureCell.identifier, for: indexPath) as? TimeTemperatureCell else { return UICollectionViewCell() }
        
        let weatherInfo = weatherList[indexPath.item]
        cell.configure(with: weatherInfo)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.size.size55, height: Constants.size.size80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.spacing.px4
    }
}
