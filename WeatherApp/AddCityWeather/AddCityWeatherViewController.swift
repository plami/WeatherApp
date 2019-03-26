//
//  AddCityWeatherViewController.swift
//  IOSTask
//
//  Created by macbook on 24.02.19.
//  Copyright © 2019 macbook. All rights reserved.
//

import UIKit

protocol AddWeatherDelegate {
    func addWeatherDidSave(vm: CityWeatherModel)
}

class AddCityWeatherViewController: UIViewController {

    @IBOutlet weak var textFieldAddWOEID: UITextField!
    var delegate: AddWeatherDelegate?
    
    let MAX_WOEID = 7
    let ACCEPTABLE_NUMBERS  = "0123456789"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem =
            UIBarButtonItem (title: "Back",
                             style: .plain,
                             target: self,
                             action: #selector(goBack))
        textFieldAddWOEID.delegate = self
        textFieldAddWOEID.placeholder = "Enter only numbers for WOEID"
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddCityWeatherViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    //MARK: Add new WOEID
    @IBAction func buttonSaveWOEID(_ sender: Any) {
        
        if let city = textFieldAddWOEID.text {
            let url = URL(string: "\(Constants.APIRequest.APIService)\(city)")!
            if Reachability.isConnectedToNetwork(){
                APIService().getCities(url: url) { city in
                    if let city = city {
                        self.delegate?.addWeatherDidSave(vm: city)
                        self.dismiss(animated: true, completion: nil)
                    }
                }
                self.dismiss(animated: true, completion: nil)
            }else {
                let alertController = UIAlertController(title: "", message: "\(Constants.Messages.NoInternet)", preferredStyle: .alert)
                
                let actionOK = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                    print("You've pressed default");
                }
                
                alertController.addAction(actionOK)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    @objc func goBack() {
        self.dismiss(animated: true, completion: nil)
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}

extension AddCityWeatherViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == textFieldAddWOEID{
            let newLength: Int = textField.text!.count + string.count - range.length
            let numberOnly = NSCharacterSet.init(charactersIn: ACCEPTABLE_NUMBERS).inverted
            let strValid = string.rangeOfCharacter(from: numberOnly) == nil
            return (strValid && (newLength <= MAX_WOEID))
        }else {
            return true
        }
    }
}
