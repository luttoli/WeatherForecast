//
//  FiveDaysCell.swift
//  WeatherForecast
//
//  Created by 김지훈 on 10/26/24.
//

import UIKit

import SnapKit

class FiveDaysCell: UITableViewCell {
    // MARK: - Components
    
    
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
        
    }
}

// MARK: - Method
extension FiveDaysCell {
    
}
