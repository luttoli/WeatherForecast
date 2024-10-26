//
//  CityListCell.swift
//  WeatherForecast
//
//  Created by 김지훈 on 10/26/24.
//

import UIKit

import SnapKit

class CityListCell: UITableViewCell {
    // MARK: - Components
    var cityNameLabel = CustomLabel(title: "", size: Constants.size.size20, weight: .SemiBold, color: .text.black)
    var countryNameLabel = CustomLabel(title: "", size: Constants.size.size15, weight: .Regular, color: .text.black)
    var separator = CustomSeparator(height: 1)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cityNameLabel.text = ""
        countryNameLabel.text = ""
    }
}

// MARK: - SetUp
private extension CityListCell {
    func setUp() {
        contentView.addSubview(cityNameLabel)
        contentView.addSubview(countryNameLabel)
        contentView.addSubview(separator)
        
        cityNameLabel.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(Constants.margin.vertical)
            $0.left.equalTo(contentView).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(contentView).offset(-Constants.margin.horizontal)
        }
        
        countryNameLabel.snp.makeConstraints {
            $0.top.equalTo(cityNameLabel.snp.bottom).offset(Constants.margin.vertical)
            $0.left.equalTo(contentView).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(contentView).offset(-Constants.margin.horizontal)
            $0.bottom.equalTo(contentView).offset(-Constants.margin.vertical)
        }
        
        separator.snp.makeConstraints {
            $0.left.equalTo(contentView).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(contentView).offset(-Constants.margin.horizontal)
            $0.bottom.equalTo(contentView)
        }
    }
}

// MARK: - Method
extension CityListCell {
    func configure(with city: CityList) {
        cityNameLabel.text = city.name
        countryNameLabel.text = city.country
    }
}
