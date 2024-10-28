//
//  UIColor.swift
//  WeatherForecast
//
//  Created by 김지훈 on 10/25/24.
//

import UIKit

extension UIColor {
    static let text = TextColor()
    static let image = ImageViewColor()
    static let background = BackGroundColor()
    static let border = BorderColor()
    static let cell = CellColor()

    struct TextColor {
        var black = UIColor.black
        var red = UIColor.red
        var darkGray = UIColor.darkGray
        var white = UIColor.white
    }
    
    struct ImageViewColor {
        var darkGray = UIColor.darkGray
    }
    
    struct BackGroundColor {
        var white = UIColor.white
    }
    
    struct BorderColor {
        var lightGray = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 0.7)
    }
    
    struct CellColor {
        var lightGray = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.0)
    }
}
