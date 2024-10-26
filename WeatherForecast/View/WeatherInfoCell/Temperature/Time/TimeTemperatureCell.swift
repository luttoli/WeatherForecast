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
    var timeLabel = CustomLabel(title: "", size: Constants.size.size15, weight: .Regular, color: .text.black)
    var iconImageView = UIImageView()
    var temperatureLabel = CustomLabel(title: "", size: Constants.size.size15, weight: .Regular, color: .text.black)
    
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
        }
        
        temperatureLabel.snp.makeConstraints {
            $0.centerX.equalTo(contentView)
            $0.top.equalTo(iconImageView.snp.bottom).offset(Constants.spacing.px8)
        }
    }
}

// MARK: - Method
extension TimeTemperatureCell {
    func configure() {
        timeLabel.text = "지금"
        iconImageView.image = .checkmark
        temperatureLabel.text = "-7°"
    }
}
