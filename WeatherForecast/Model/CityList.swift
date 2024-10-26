//
//  CityList.swift
//  WeatherForecast
//
//  Created by 김지훈 on 10/27/24.
//

import UIKit

struct CityList: Codable {
    let id: Int
    let name: String
    let country: String
    let coord: Coordinate
}

struct Coordinate: Codable {
    let lon: Double
    let lat: Double
}
