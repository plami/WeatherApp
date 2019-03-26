//
//  DefaultsUtil.swift
//  IOSTask
//
//  Created by macbook on 25.02.19.
//  Copyright © 2019 macbook. All rights reserved.
//

import Foundation

class DefaultsUtil: UserDefaults {
    
    func decodingCities<T: Codable>(key: String, returnType: T.Type) -> T? {
        var cities: T?
        if let value = UserDefaults.standard.data(forKey: key) {
            cities = try? JSONDecoder().decode(T.self, from: value)
        }
        return cities
    }
    
    func encodingCities<T: Codable> (key: String, value: T) {
        let citiesData = try? JSONEncoder().encode(value)
        UserDefaults.standard.set(citiesData, forKey: key)
    }
}
