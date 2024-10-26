//
//  SearchViewModel.swift
//  WeatherForecast
//
//  Created by 김지훈 on 10/27/24.
//

import UIKit

import RxSwift

class SearchViewModel {
    private let citiesParsing = CitiesParsing()
    private let disposeBag = DisposeBag()
    
    let cities = PublishSubject<[CityList]>()
    
    init() {
        fetchCities()
    }
    
    func fetchCities() {
        citiesParsing.fetchCities()
            .subscribe(onNext: { [weak self] cities in
                self?.cities.onNext(cities)
            }, onError: { error in
                print("Error fetching cities: \(error)")
            })
            .disposed(by: disposeBag)
    }
}
