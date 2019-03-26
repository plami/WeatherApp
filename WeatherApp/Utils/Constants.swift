//
//  Constants.swift
//  IOSTask
//
//  Created by macbook on 21.02.19.
//  Copyright © 2019 macbook. All rights reserved.
//

import Foundation

struct Constants {
    
    struct APIRequest {
        static let APIService = "https://www.metaweather.com/api/location/"
        static let APIServiceImages = "https://www.metaweather.com/static/img/weather/png/64/"
        static let firstWOEID = "839722"
        static let secondWOEID = "2459115"
        static let thirdWOEID = "1118370"
    }
    
    struct Messages {
        static let NoInternet = "Currently there is no internet connection!"
        static let GeneralError = "Something went wrong.Please try again later!"
        static let notValidWOEID = "The entered city WOEID was not valid!"
    }
}
