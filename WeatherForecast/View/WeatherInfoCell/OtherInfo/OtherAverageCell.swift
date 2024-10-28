//
//  OtherAverageCell.swift
//  WeatherForecast
//
//  Created by 김지훈 on 10/26/24.
//

import UIKit

import RxSwift
import SnapKit

class OtherAverageCell: UITableViewCell {
    // MARK: - Properties
    private let viewModel = WeatherViewModel()
    private let disposeBag = DisposeBag()
    private var weatherData: [Weather] = []
    private var weatherList: [List] = []
    
    // MARK: - Components
    let averageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let averageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        averageCollectionView.register(AverageCell.self, forCellWithReuseIdentifier: AverageCell.identifier)
        averageCollectionView.backgroundColor = .clear
        averageCollectionView.showsHorizontalScrollIndicator = false
        averageCollectionView.isScrollEnabled = false
        return averageCollectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
        bindViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

// MARK: - SetUp
private extension OtherAverageCell {
    func setUp() {
        contentView.addSubview(averageCollectionView)
        
        averageCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        averageCollectionView.delegate = self
        averageCollectionView.dataSource = self
    }
}

// MARK: - Method
extension OtherAverageCell {
    private func bindViewModel() {
        viewModel.weather
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] weatherData in
                self?.weatherData = weatherData
                self?.updateUpcomingWeatherList()
                self?.averageCollectionView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    private func updateUpcomingWeatherList() {
        guard let weather = weatherData.first, let weatherList = weather.list else {
            print("weatherData 또는 weather.list가 비어있음")
            return
        }
        
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

        self.weatherList = Array(weatherList[closestIndex..<min(closestIndex + 7, weatherList.count)])
    }
}

// MARK: - CollectionViewDelegate
extension OtherAverageCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AverageCell.identifier, for: indexPath) as? AverageCell else { return UICollectionViewCell() }
        
        cell.backgroundColor = .systemBlue
        
        cell.layer.cornerRadius = Constants.radius.px12
        cell.layer.masksToBounds = true
        
        let averageHumidity = calculateAverageHumidity()
        let averageClouds = calculateAverageClouds()
        let averageWind = calculateAverageWind()
        let averagePressure = calculateAveragePressure()
        
        cell.configure(with: indexPath, humidity: averageHumidity, clouds: averageClouds, averageWind: averageWind, pressure: averagePressure)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 2 - Constants.margin.vertical
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.margin.horizontal
    }
}

extension OtherAverageCell {
    private func calculateAverageHumidity() -> String {
        guard !weatherList.isEmpty else { return "데이터 없음" }
        
        let totalHumidity = weatherList.map { Double($0.main?.humidity ?? 0) }.reduce(0, +)
        let averageHumidity = totalHumidity / Double(weatherList.count)
        return String(format: "%.0f%%", averageHumidity)
    }
    
    private func calculateAverageClouds() -> String {
        guard !weatherList.isEmpty else { return "데이터 없음" }
        
        let totalClouds = weatherList.map { Double($0.clouds?.all ?? 0) }.reduce(0, +)
        let averageClouds = totalClouds / Double(weatherList.count)
        return String(format: "%.0f%%", averageClouds)
    }
    
    private func calculateAverageWind() -> String {
        guard !weatherList.isEmpty else { return "데이터 없음" }
        
        let totalWind = weatherList.map { $0.wind?.speed ?? 0 }.reduce(0, +)
        let averageWind = totalWind / Double(weatherList.count)
        return String(format: "%.2fm/s", averageWind)
    }
    
    private func calculateAveragePressure() -> String {
        guard !weatherList.isEmpty else { return "데이터 없음" }
        
        let totalPressure = weatherList.map { Double($0.main?.pressure ?? 0) }.reduce(0, +)
        let averagePressure = totalPressure / Double(weatherList.count)
        return String(format: "%.0fhpa", averagePressure)
    }
}
