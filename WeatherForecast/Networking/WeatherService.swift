//
//  WeatherService.swift
//  WeatherForecast
//
//  Created by 김지훈 on 10/27/24.
//

import UIKit

import Alamofire
import RxSwift

class WeatherService {
    private var apiKey: String {
        guard let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
              let xml = FileManager.default.contents(atPath: path),
              let config = try? PropertyListDecoder().decode([String: String].self, from: xml) else {
            fatalError("API Key not found")
        }
        return config["API_KEY"] ?? ""
    }
    
    func fetchWeatherForecast(lat: Double, lon: Double) -> Observable<[Weather]> {
        let url = "https://api.openweathermap.org/data/2.5/forecast"
        let parameters: [String: Any] = [
            "lat": lat,
            "lon": lon,
            "appid": apiKey
        ]
        
        return Observable.create { observer in
            AF.request(url, method: .get, parameters: parameters)
                .validate()
                .responseDecodable(of: Weather.self) { response in
                    switch response.result {
                    case .success(let weather):
                        observer.onNext([weather])
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
            
            return Disposables.create()
        }
    }
}
