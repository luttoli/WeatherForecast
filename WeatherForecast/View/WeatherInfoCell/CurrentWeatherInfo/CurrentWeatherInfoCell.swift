//
//  CurrentWeatherInfoCell.swift
//  WeatherForecast
//
//  Created by 김지훈 on 10/25/24.
//

import UIKit

import SnapKit

class CurrentWeatherInfoCell: UITableViewCell {
    // MARK: - Components
    var cityNameLabel = CustomLabel(title: "", size: Constants.size.size40, weight: .Regular, color: .text.black)
    var temperatureLabel = CustomLabel(title: "", size: Constants.size.size80, weight: .medium, color: .text.black)
    var weatherLabel = CustomLabel(title: "", size: Constants.size.size30, weight: .Regular, color: .text.black)
    var bestTemperatureLabel = CustomLabel(title: "", size: Constants.size.size20, weight: .Regular, color: .text.black)
    var contourLabel = CustomLabel(title: "|", size: Constants.size.size20, weight: .Regular, color: .text.black)
    var lowestTemperatureLabel = CustomLabel(title: "", size: Constants.size.size20, weight: .Regular, color: .text.black)
    
    private lazy var bestLowestHorizontalStackView: UIStackView = {
        let bestLowestHorizontalStackView = UIStackView(arrangedSubviews: [bestTemperatureLabel, contourLabel, lowestTemperatureLabel])
        bestLowestHorizontalStackView.axis = .horizontal
        bestLowestHorizontalStackView.spacing = Constants.margin.horizontal
        bestLowestHorizontalStackView.alignment = .center
        return bestLowestHorizontalStackView
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
    }
}

// MARK: - SetUp
private extension CurrentWeatherInfoCell {
    func setUp() {
        contentView.addSubview(cityNameLabel)
        contentView.addSubview(temperatureLabel)
        contentView.addSubview(weatherLabel)
        contentView.addSubview(bestLowestHorizontalStackView)
        
        cityNameLabel.snp.makeConstraints {
            $0.centerX.equalTo(contentView)
            $0.top.equalTo(contentView).offset(Constants.margin.vertical)
        }
        
        temperatureLabel.snp.makeConstraints {
            $0.centerX.equalTo(contentView)
            $0.top.equalTo(cityNameLabel.snp.bottom).offset(Constants.margin.vertical)
        }
        
        weatherLabel.snp.makeConstraints {
            $0.centerX.equalTo(contentView)
            $0.top.equalTo(temperatureLabel.snp.bottom).offset(Constants.margin.vertical)
        }
        
        bestLowestHorizontalStackView.snp.makeConstraints {
            $0.centerX.equalTo(contentView)
            $0.top.equalTo(weatherLabel.snp.bottom).offset(Constants.margin.vertical)
            $0.bottom.equalTo(contentView).offset(-Constants.margin.vertical)
        }
    }
}

// MARK: - Method
extension CurrentWeatherInfoCell {
    func configure(with weather: Weather) {
        guard let city = weather.city,
              let weatherList = weather.list else { return }
        
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "Asia/Seoul")
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        
        let closestWeather = weatherList.min { item1, item2 in
            guard let date1 = dateFormatter.date(from: item1.dtTxt ?? ""),
                  let date2 = dateFormatter.date(from: item2.dtTxt ?? "") else {
                return false
            }
            return abs(date1.timeIntervalSince(now)) < abs(date2.timeIntervalSince(now))
        }
        
        cityNameLabel.text = city.name ?? ""
        
        if let main = closestWeather?.main {
            temperatureLabel.text = "\(toCelsius(main.temp ?? 0))°"
            bestTemperatureLabel.text = "최고: \(toCelsius(main.tempMax ?? 0))°"
            lowestTemperatureLabel.text = "최저: \(toCelsius(main.tempMin ?? 0))°"
        }
        
        weatherLabel.text = closestWeather?.weather?.first?.main ?? ""
    }
}
