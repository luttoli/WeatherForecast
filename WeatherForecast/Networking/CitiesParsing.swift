//
//  CitiesParsing.swift
//  WeatherForecast
//
//  Created by 김지훈 on 10/27/24.
//

import UIKit

import Alamofire
import RxSwift

class CitiesParsing {
    func fetchCities() -> Observable<[CityList]> {
        guard let url = Bundle.main.url(forResource: "reduced_citylist", withExtension: "json") else {
            return Observable.just([])
        }
        
        return Observable.create { observer in
            AF.request(url).responseDecodable(of: [CityList].self) { response in
                switch response.result {
                case .success(let cities):
                    observer.onNext(cities)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
