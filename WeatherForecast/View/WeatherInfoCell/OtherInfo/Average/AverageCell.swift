//
//  AverageCell.swift
//  WeatherForecast
//
//  Created by 김지훈 on 10/26/24.
//

import UIKit

import SnapKit

class AverageCell: UICollectionViewCell {
    // MARK: - Components
    var titles: [String] = ["습도", "구름", "바람 속도", "기압"]
    
    var titleLabel = CustomLabel(title: "", size: Constants.size.size15, weight: .light, color: .text.white)
    var averageLabel = CustomLabel(title: "", size: Constants.size.size35, weight: .SemiBold, color: .text.white)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SetUp
private extension AverageCell {
    func setUp() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(averageLabel)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(Constants.margin.vertical)
            $0.leading.equalTo(contentView).offset(Constants.margin.horizontal)
        }
        
        averageLabel.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.leading.equalTo(contentView).offset(Constants.margin.horizontal)
        }
        averageLabel.numberOfLines = 0
    }
}

// MARK: - Method
extension AverageCell {
    func configure(with indexPath: IndexPath, humidity: String, clouds: String, averageWind: String, pressure: String) {
        let titleIndex = indexPath.row % titles.count
        titleLabel.text = titles[titleIndex]
        
        switch titleIndex {
        case 0:
            averageLabel.text = humidity
        case 1:
            averageLabel.text = clouds
        case 2:
            averageLabel.text = averageWind
        case 3:
            averageLabel.text = pressure
        default:
            averageLabel.text = "데이터 없음"
        }
    }
}
