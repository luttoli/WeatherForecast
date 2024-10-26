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
    var bestTemperatuerLabel = CustomLabel(title: "", size: Constants.size.size20, weight: .Regular, color: .text.black)
    var contourLabel = CustomLabel(title: "|", size: Constants.size.size20, weight: .Regular, color: .text.black)
    var lowestTemperatuerLabel = CustomLabel(title: "", size: Constants.size.size20, weight: .Regular, color: .text.black)
    
    private lazy var bestLowestHorizontalStackView: UIStackView = {
        let bestLowestHorizontalStackView = UIStackView(arrangedSubviews: [bestTemperatuerLabel, contourLabel, lowestTemperatuerLabel])
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
    func configure() {
        cityNameLabel.text = "Seoul"
        temperatureLabel.text = "-7°"
        weatherLabel.text = "맑음"
        bestTemperatuerLabel.text = "최고: -1°"
        lowestTemperatuerLabel.text = "최저: -11°"
    }
}
