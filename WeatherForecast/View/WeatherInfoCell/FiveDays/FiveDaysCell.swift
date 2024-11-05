//
//  FiveDaysCell.swift
//  WeatherForecast
//
//  Created by 김지훈 on 10/26/24.
//

import UIKit

import SnapKit

class FiveDaysCell: UITableViewCell {
    // MARK: - Properties
    private let viewModel = WeatherViewModel()
    
    // MARK: - Components
    var dayLabel = CustomLabel(title: "", size: Constants.size.size15, weight: .SemiBold, color: .text.white)
    var iconImageView = UIImageView()
    var temperatureLabel = CustomLabel(title: "", size: Constants.size.size15, weight: .SemiBold, color: .text.white)
    var separator = CustomSeparator(height: 1)
    
    private lazy var dayInfoHorizontalStackView: UIStackView = {
        let dayInfoHorizontalStackView = UIStackView(arrangedSubviews: [dayLabel, iconImageView, temperatureLabel])
        dayInfoHorizontalStackView.axis = .horizontal
        dayInfoHorizontalStackView.spacing = 0
        dayInfoHorizontalStackView.alignment = .center
        dayInfoHorizontalStackView.distribution = .equalSpacing
        temperatureLabel.textAlignment = .right
        return dayInfoHorizontalStackView
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
private extension FiveDaysCell {
    func setUp() {
        contentView.addSubview(dayInfoHorizontalStackView)
        contentView.addSubview(separator)
        
        dayLabel.snp.makeConstraints {
            $0.width.equalTo(Constants.size.size30)
        }
        
        iconImageView.snp.makeConstraints {
            $0.width.height.equalTo(Constants.size.size30)
        }
        
        temperatureLabel.snp.makeConstraints {
            $0.width.equalTo(Constants.size.size150)
        }
        
        dayInfoHorizontalStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(contentView).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(contentView).offset(-Constants.margin.horizontal)
        }
        
        separator.snp.makeConstraints {
            $0.leading.equalTo(contentView).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(contentView).offset(-Constants.margin.horizontal)
            $0.bottom.equalTo(contentView)
        }
    }
}

// MARK: - Method
extension FiveDaysCell {
    func firstConfigure(with weather: Weather) {
        guard let weatherList = weather.list else { return }
        
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
        
        dayLabel.text = "오늘"
        
        if let main = closestWeather?.main {
            if let weather = closestWeather, let iconCode = weather.weather?.first?.icon {
                iconImageView.image = Icon.loadIcon(for: iconCode)
            } else {
                iconImageView.image = nil
            }
            
            let lowestTemp = "최저: \(toCelsius(main.tempMin ?? 0))°"
            let bestTemp = "최고: \(toCelsius(main.tempMax ?? 0))°"
            
            temperatureLabel.text = "\(lowestTemp)   \(bestTemp)"
        }
    }
    
    func configure(forDay dayOffset: Int, with weather: Weather) {
        guard let weatherList = weather.list else { return }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "Asia/Seoul")
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        
        let targetDate = Calendar.current.date(byAdding: .day, value: dayOffset, to: Date()) ?? Date()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let targetDateString = dateFormatter.string(from: targetDate) + " 12:00:00"
        
        let specificWeather = weatherList.first { item in
            return item.dtTxt == targetDateString
        }
        
        if let dt = specificWeather?.dt {
            let date = Date(timeIntervalSince1970: TimeInterval(dt))
            let dayFormatter = DateFormatter()
            dayFormatter.dateFormat = "E"
            dayFormatter.locale = Locale(identifier: "ko_KR")
            dayLabel.text = dayFormatter.string(from: date)
        }
        
        if let main = specificWeather?.main {
            if let iconCode = specificWeather?.weather?.first?.icon {
                iconImageView.image = Icon.loadIcon(for: iconCode)
            } else {
                iconImageView.image = nil
            }
            
            let lowestTemp = "최저: \(toCelsius(main.tempMin ?? 0))°"
            let bestTemp = "최고: \(toCelsius(main.tempMax ?? 0))°"
            
            temperatureLabel.text = "\(lowestTemp)   \(bestTemp)"
        }
    }
}
