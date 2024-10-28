//
//  WeatherInfoViewModel.swift
//  WeatherForecast
//
//  Created by 김지훈 on 10/27/24.
//

import UIKit

import RxSwift

class WeatherViewModel {
    private let weatherService = WeatherService()
    private let disposeBag = DisposeBag()

    private let location = BehaviorSubject<(lat: Double, lon: Double)>(value: (36.783611, 127.004173))
    
    var weather: Observable<[Weather]> {
        return location
            .flatMapLatest { [weak self] lat, lon in
                self?.weatherService.fetchWeatherForecast(lat: lat, lon: lon) ?? .empty()
            }
    }
    
    func updateLocation(lat: Double, lon: Double) {
        location.onNext((lat, lon))
    }
    
    func getDayOfWeek(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter.string(from: date)
    }
}
