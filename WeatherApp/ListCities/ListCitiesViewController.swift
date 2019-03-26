//
//  ViewController.swift
//  IOSTask
//
//  Created by macbook on 21.02.19.
//  Copyright © 2019 macbook. All rights reserved.
//

import UIKit
import Foundation

class ListCitiesViewController: UIViewController, AddWeatherDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var cityVM: WeatherViewModel!
    var viewModels = [WeatherViewModel]()
    private var defaultsUtil: DefaultsUtil = DefaultsUtil()
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var citieModels: [CityWeatherModel] {
        get {
            return defaultsUtil.decodingCities(key: "cities", returnType: [CityWeatherModel].self) ?? []
        }
        set {
            defaultsUtil.encodingCities(key: "cities", value: citieModels)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setup2()
        setup3()

        activityIndicator.startAnimating()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        registerTableViewCell()
    }
    
    func addWeatherDidSave(vm: CityWeatherModel) {
        self.cityVM = WeatherViewModel(vm)
        self.viewModels.append(self.cityVM)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    //MARK: Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "AddCityWeatherViewController" {
            prepareSegueForAddWeatherCityViewController(segue: segue)
        }
    }
    
    private func prepareSegueForAddWeatherCityViewController(segue: UIStoryboardSegue) {
        guard let nav = segue.destination as? UINavigationController else {
            fatalError("NavigationController not found")
        }
        
        guard let addWeatherCityVC = nav.viewControllers.first as? AddCityWeatherViewController else {
            fatalError("AddCityWeatherViewController not found")
        }
        addWeatherCityVC.delegate = self
    }
}

//MARK: TableViewDelegates
extension ListCitiesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModels.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detailsViewController = storyBoard.instantiateViewController(withIdentifier: "WeatherDetailsViewController") as! WeatherDetailsViewController
        detailsViewController.consolidatedWeather = viewModels[indexPath.row].consolidatedWeather
        detailsViewController.navigationItem.title = viewModels[indexPath.row].title
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as! CityTableViewCell
        
        cell.textLabel?.text = viewModels[indexPath.row].title
        
        return cell
    }
    
    private func setup() {

        let url = URL(string: "\(Constants.APIRequest.APIService)\(Constants.APIRequest.firstWOEID)")!
        if Reachability.isConnectedToNetwork(){
            APIService().getCities(url: url) { [weak self] city in
                guard let city = city else { return }
                self?.cityVM = WeatherViewModel(city)
                self?.viewModels.append((self?.cityVM)!)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.activityIndicator.isHidden = true
                    self?.activityIndicator.stopAnimating()
                }
            }
        }else {
            let alertController = UIAlertController(title: "", message: "\(Constants.Messages.NoInternet)", preferredStyle: .alert)
            
            let actionOK = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                print("You've pressed default");
            }
            
            alertController.addAction(actionOK)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    private func setup2() {
        
        let url = URL(string: "\(Constants.APIRequest.APIService)\(Constants.APIRequest.secondWOEID)")!
        
        if Reachability.isConnectedToNetwork(){
            APIService().getCities(url: url) {[weak self] city in
                guard let city = city else { return }
                self?.cityVM = WeatherViewModel(city)
                self?.viewModels.append((self?.cityVM)!)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.activityIndicator.isHidden = true
                    self?.activityIndicator.stopAnimating()
                }
            }
        }else {
            let alertController = UIAlertController(title: "", message: "\(Constants.Messages.NoInternet)", preferredStyle: .alert)
            
            let actionOK = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                print("You've pressed default");
            }
            
            alertController.addAction(actionOK)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    private func setup3() {
        
        let url = URL(string: "\(Constants.APIRequest.APIService)\(Constants.APIRequest.thirdWOEID)")!
        
        if Reachability.isConnectedToNetwork(){
            APIService().getCities(url: url) {[weak self] city in
                guard let city = city else { return }
                self?.cityVM = WeatherViewModel(city)
                self?.viewModels.append((self?.cityVM)!)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.activityIndicator.isHidden = true
                    self?.activityIndicator.stopAnimating()
                }
            }
        }else {
            let alertController = UIAlertController(title: "", message: "\(Constants.Messages.NoInternet)", preferredStyle: .alert)
            
            let actionOK = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                print("You've pressed default");
            }
            
            alertController.addAction(actionOK)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func registerTableViewCell() {
        let nib = UINib(nibName: "CityTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cityCell")
    }
}
