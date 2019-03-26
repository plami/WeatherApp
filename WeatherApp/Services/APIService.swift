//
//  APIService.swift
//  IOSTask
//
//  Created by macbook on 21.02.19.
//  Copyright © 2019 macbook. All rights reserved.
//

import Foundation

class APIService {
    
    func getCities(url: URL, completion: @escaping (CityWeatherModel?) -> ()) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {
                
                let city = try? JSONDecoder().decode(CityWeatherModel.self, from: data)
                if let city = city {
                    completion(city)
                }
            }
        }.resume()
    }
    
}
