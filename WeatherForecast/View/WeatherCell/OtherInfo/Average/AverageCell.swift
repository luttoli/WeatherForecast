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
    var averages: [String] = ["56%", "50%", "1.97m/s", "1,030hpa"]
    
    var titleLabel = CustomLabel(title: "", size: Constants.size.size15, weight: .light, color: .text.black)
    var averageLabel = CustomLabel(title: "", size: Constants.size.size35, weight: .Regular, color: .text.black)
    
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
    }
}

// MARK: - Method
extension AverageCell {
    func configure(with indexPath: IndexPath) {
        let titleIndex = indexPath.row % titles.count
        let averageIndex = indexPath.row % averages.count
        titleLabel.text = titles[titleIndex]
        averageLabel.text = averages[averageIndex]
    }
}
