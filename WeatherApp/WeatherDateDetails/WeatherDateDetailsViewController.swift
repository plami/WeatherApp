//
//  WeatherDateDetailsViewController.swift
//  IOSTask
//
//  Created by macbook on 24.02.19.
//  Copyright © 2019 macbook. All rights reserved.
//

import UIKit

class WeatherDateDetailsViewController: UIViewController {

    @IBOutlet weak var imageWeather: UIImageView!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelTemperature: UILabel!
    @IBOutlet weak var labelMaxTemperature: UILabel!
    @IBOutlet weak var labelMinTemperature: UILabel!
    @IBOutlet weak var labelWindSpeed: UILabel!
    @IBOutlet weak var labelWindDirection: UILabel!
    @IBOutlet weak var labelAirPressure: UILabel!
    @IBOutlet weak var labelHumidity: UILabel!
    @IBOutlet weak var labelVisibility: UILabel!
    @IBOutlet weak var labelPredictability: UILabel!
    
    var dates: String?
    var urlImage: String?
    var temperatures: Double?
    var maxTemperatures: Double?
    var minTemperatures: Double?
    var windSpeed: Double?
    var windDirection: Double?
    var airPressure: Double?
    var visibility: Double?
    var humidity: Int?
    var predictability: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabelsAndImages()
    }
    
    func setupLabelsAndImages (){
        self.labelDate.text = dates
        guard let temperature = temperatures,
              let maxTemperature = maxTemperatures,
              let minTemperature = minTemperatures,
              let windSpeed = windSpeed,
              let windDirection = windDirection,
              let airPressure = airPressure,
              let visibility = visibility,
              let humidity = humidity,
              let predictability = predictability,
              let urlString = urlImage
            else { return }
        
        let url = URL(string: urlString)
        do {
            if let url = url {
                let data = try Data(contentsOf:url)
                imageWeather.image = UIImage(data: data)
            }
        } catch _ {
            let alertController = UIAlertController(title: "", message: "\(Constants.Messages.NoInternet)", preferredStyle: .alert)
            
            let actionOK = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                print("You've pressed default");
            }
            
            alertController.addAction(actionOK)
            self.present(alertController, animated: true, completion: nil)
        }
        
        self.labelTemperature.text = "temperature: \(String(describing: temperature))"
        self.labelMaxTemperature.text = "max. temperature: \(String(describing: maxTemperature))"
        self.labelMinTemperature.text = "min. temperature: \(String(describing: minTemperature))"
        self.labelWindSpeed.text = "windspeed: \(String(describing: windSpeed))"
        self.labelWindDirection.text = "wind direction: \(String(describing: windDirection))"
        self.labelAirPressure.text = "air pressure: \(String(describing: airPressure))"
        self.labelVisibility.text = "visibilty: \(String(describing: visibility))"
        self.labelHumidity.text = "humidity: \(String(describing: humidity))"
        self.labelPredictability.text = "predictability: \(String(describing: predictability))"
    }
}
