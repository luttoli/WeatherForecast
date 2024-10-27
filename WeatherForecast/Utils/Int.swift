//
//  Int.swift
//  WeatherForecast
//
//  Created by 김지훈 on 10/27/24.
//

import UIKit

func toCelsius(_ kelvin: Double?) -> String {
    guard let kelvin = kelvin else { return "" }
    let celsius = (kelvin - 273.15).rounded()
    return String(Int(celsius))
}
