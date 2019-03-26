//
//  CityWeatherViewModel.swift
//  IOSTask
//
//  Created by macbook on 22.02.19.
//  Copyright © 2019 macbook. All rights reserved.
//

import Foundation

struct WeatherViewModel {
    private let city:CityWeatherModel
}

extension WeatherViewModel {
    init(_ city: CityWeatherModel) {
        self.city = city
    }
}

extension WeatherViewModel {
    
    var title: String {
        return self.city.title
    }
    
    var consolidatedWeather: [ConsolidatedWeather] {
        return self.city.consolidatedWeather
    }
}
