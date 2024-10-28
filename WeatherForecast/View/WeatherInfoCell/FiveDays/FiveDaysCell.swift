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
    var dayLabel = CustomLabel(title: "", size: Constants.size.size15, weight: .Regular, color: .text.black)
    var iconImageView = UIImageView()
    var temperatureLabel = CustomLabel(title: "", size: Constants.size.size15, weight: .Regular, color: .text.black)
    var separator = CustomSeparator(height: 1)
    
    private lazy var dayInfoHorizontalStackView: UIStackView = {
        let dayInfoHorizontalStackView = UIStackView(arrangedSubviews: [dayLabel, iconImageView, temperatureLabel])
        dayInfoHorizontalStackView.axis = .horizontal
        dayInfoHorizontalStackView.spacing = 0
        dayInfoHorizontalStackView.alignment = .center
        dayInfoHorizontalStackView.distribution = .equalSpacing
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
//    func configure() {
//        dayLabel.text = "오늘"
//        iconImageView.image = .checkmark
//        temperatureLabel.text = "최소: -7°   최고: 25°"
//    }
    
    
    
}
