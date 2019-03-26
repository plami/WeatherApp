//
//  CityWeather.swift
//  IOSTask
//
//  Created by macbook on 21.02.19.
//  Copyright © 2019 macbook. All rights reserved.
//

import Foundation

struct CityWeatherModel: Codable {
    
    let title: String
    let consolidatedWeather: [ConsolidatedWeather]
    
    private enum CodingKeys: String, CodingKey {
        case title = "title"
        case consolidatedWeather = "consolidated_weather"
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        consolidatedWeather = try container.decode([ConsolidatedWeather].self, forKey: .consolidatedWeather)
    }
}

struct ConsolidatedWeather: Codable {
    
    let id: Int
    var temperature: Double
    let temperatureMin: Double
    let temperatureMax: Double
    let windSpeed: Double
    let windDirection: Double
    let airPressure: Double
    let visibility: Double
    let humidity: Int
    let predictability: Int
    let weatherState: String
    let weatherStateAbr: String
    let windDirectionCompass: String
    let created: String
    let date: String
    
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case weatherState = "weather_state_name"
        case weatherStateAbr = "weather_state_abbr"
        case windDirectionCompass = "created"
        case created = "wind_direction_compass"
        case temperature = "the_temp"
        case temperatureMin = "min_temp"
        case temperatureMax = "max_temp"
        case windSpeed = "wind_direction"
        case windDirection = "wind_speed"
        case airPressure = "air_pressure"
        case visibility = "visibility"
        case humidity = "humidity"
        case predictability = "predictability"
        case date = "applicable_date"
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        temperature = try container.decode(Double.self, forKey: .temperature)
        temperatureMin = try container.decode(Double.self, forKey: .temperatureMin)
        temperatureMax = try container.decode(Double.self, forKey: .temperatureMax)
        weatherState = try container.decode(String.self, forKey: .weatherState)
        weatherStateAbr = try container.decode(String.self, forKey: .weatherStateAbr)
        temperature = try container.decode(Double.self, forKey: .temperature)
        windSpeed = try container.decode(Double.self, forKey: .windSpeed)
        windDirection = try container.decode(Double.self, forKey: .windDirection)
        airPressure = try container.decode(Double.self, forKey: .airPressure)
        visibility = try container.decode(Double.self, forKey: .visibility)
        humidity = try container.decode(Int.self, forKey: .humidity)
        predictability = try container.decode(Int.self, forKey: .predictability)
        date = try container.decode(String.self, forKey: .date)
        windDirectionCompass = try container.decode(String.self, forKey: .windDirectionCompass)
        created = try container.decode(String.self, forKey: .created)
    }
    
}
