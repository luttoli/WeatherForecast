//
//  Icon.swift
//  WeatherForecast
//
//  Created by 김지훈 on 10/28/24.
//

import UIKit

class Icon {
    static func loadIcon(for iconName: String) -> UIImage? {
        if let iconImage = UIImage(named: iconName) {
            return iconImage
        } else if iconName.hasSuffix("n") {
            let dayIconName = iconName.replacingOccurrences(of: "n", with: "d")
            return UIImage(named: dayIconName)
        }
        return nil
    }
}
