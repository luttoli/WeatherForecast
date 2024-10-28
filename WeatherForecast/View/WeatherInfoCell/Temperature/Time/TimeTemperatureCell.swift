//
//  TimeTemperatureCell.swift
//  WeatherForecast
//
//  Created by 김지훈 on 10/26/24.
//

import UIKit

import SnapKit

class TimeTemperatureCell: UICollectionViewCell {
    // MARK: - Components
    var timeLabel = CustomLabel(title: "", size: Constants.size.size15, weight: .SemiBold, color: .text.white)
    var iconImageView = UIImageView()
    var temperatureLabel = CustomLabel(title: "", size: Constants.size.size15, weight: .SemiBold, color: .text.white)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SetUp
private extension TimeTemperatureCell {
    func setUp() {
        contentView.addSubview(timeLabel)
        contentView.addSubview(iconImageView)
        contentView.addSubview(temperatureLabel)
        
        timeLabel.snp.makeConstraints {
            $0.centerX.equalTo(contentView)
            $0.top.equalTo(contentView)
        }
        
        iconImageView.snp.makeConstraints {
            $0.centerX.equalTo(contentView)
            $0.top.equalTo(timeLabel.snp.bottom).offset(Constants.spacing.px8)
            $0.width.height.equalTo(Constants.size.size30)
        }
        
        temperatureLabel.snp.makeConstraints {
            $0.centerX.equalTo(contentView)
            $0.bottom.equalTo(contentView)
        }
    }
}

// MARK: - Method
extension TimeTemperatureCell {
    func configure(with weatherInfo: List) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "Asia/Seoul")
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        
        if let timeText = weatherInfo.dtTxt, let date = dateFormatter.date(from: timeText) {
            dateFormatter.dateFormat = "HH시"
            timeLabel.text = dateFormatter.string(from: date)
        } else {
            timeLabel.text = ""
        }
        
        if let weather = weatherInfo.weather?.first, let iconCode = weather.icon {
            iconImageView.image = Icon.loadIcon(for: iconCode)
        } else {
            iconImageView.image = nil
        }

        if let main = weatherInfo.main {
            temperatureLabel.text = "\(toCelsius(main.temp ?? 0))°"
        } else {
            temperatureLabel.text = ""
        }
    }
}
