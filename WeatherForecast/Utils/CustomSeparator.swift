//
//  CustomSeparator.swift
//  WeatherForecast
//
//  Created by 김지훈 on 10/26/24.
//

import UIKit

import SnapKit

class CustomSeparator: UIView {
    // MARK: - Comnponents
    private let separator: UIView = {
        let separator = UIView()
        return separator
    }()
    
    init(height: CGFloat) {
        super.init(frame: .zero)
        setUp(height: height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - setUp
private extension CustomSeparator {
    /// UIView Separator setUp
    /// - Parameter heignt : 높이
    func setUp(height: CGFloat) {
        backgroundColor = .border.lightGray
        self.snp.makeConstraints {
            $0.height.equalTo(height)
        }
    }
}
