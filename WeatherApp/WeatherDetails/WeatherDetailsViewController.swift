//
//  WeatherDetailsViewController.swift
//  IOSTask
//
//  Created by macbook on 22.02.19.
//  Copyright © 2019 macbook. All rights reserved.
//

import UIKit

class WeatherDetailsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var consolidatedWeather: [ConsolidatedWeather] = []
    var dates: [String] = []
    var weatherState: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        registerCustomCell()
        datesWeatherForecast()
    }
    
    func datesWeatherForecast(){
        for element in consolidatedWeather{
            dates.append(element.date)
            weatherState.append(element.weatherStateAbr)
        }
    }
}

extension WeatherDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return consolidatedWeather.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weatherDetailsCell", for: indexPath as IndexPath) as! WeatherDetailsCollectionViewCell
        cell.labelDate.text = dates[indexPath.row]
        
        let url = URL(string: "\(Constants.APIRequest.APIServiceImages)\(weatherState[indexPath.row]).png")
        do {
            if let url = url {
                let data = try Data(contentsOf:url)
                cell.imageWeather.image = UIImage(data: data)
            }
        } catch _ {
            let alertController = UIAlertController(title: "", message: "\(Constants.Messages.NoInternet)", preferredStyle: .alert)
            
            let actionOK = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                print("You've pressed default");
            }
            
            alertController.addAction(actionOK)
            self.present(alertController, animated: true, completion: nil)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detailsViewController = storyBoard.instantiateViewController(withIdentifier: "WeatherDateDetailsViewController") as! WeatherDateDetailsViewController
        detailsViewController.dates = consolidatedWeather[indexPath.row].date
        detailsViewController.urlImage = "\(Constants.APIRequest.APIServiceImages)\(weatherState[indexPath.row]).png"
        detailsViewController.temperatures = Double(round(1000*consolidatedWeather[indexPath.row].temperature)/1000)
        detailsViewController.maxTemperatures = Double(round(1000*consolidatedWeather[indexPath.row].temperatureMax)/1000)
        detailsViewController.minTemperatures = Double(round(1000*consolidatedWeather[indexPath.row].temperatureMin)/1000)
        detailsViewController.windSpeed = Double(round(1000*consolidatedWeather[indexPath.row].windSpeed)/1000)
        detailsViewController.windDirection = Double(round(1000*consolidatedWeather[indexPath.row].windDirection)/1000)
        detailsViewController.airPressure = Double(round(1000*consolidatedWeather[indexPath.row].airPressure)/1000)
        detailsViewController.visibility = Double(round(1000*consolidatedWeather[indexPath.row].visibility)/1000)
        detailsViewController.humidity = consolidatedWeather[indexPath.row].humidity
        detailsViewController.predictability = consolidatedWeather[indexPath.row].predictability
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
    func registerCustomCell() {
        
        let nib = UINib(nibName: "WeatherDetailsCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "weatherDetailsCell")
    }
}
