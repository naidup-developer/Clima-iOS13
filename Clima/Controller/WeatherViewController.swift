//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    let WEATHER_API_KEY = "4245b4758713772af64cfa8f881dbd0a"
    
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherManager.delegateUpdateWeatherData = self
        searchTextField.delegate = self
    }

    @IBAction func onClickSearch(_ sender: UIButton) {
        searchTextField.endEditing(true)
        print(searchTextField.text ?? "na")
    }
    
    
    
}


//MARK: - Update Weather Data Delegate
extension WeatherViewController : UpdateWeatherDataDelegate
{
    func didFailWithError(_ error: Error!) {
        print(error as Any)
    }
    
    func didUpdateWeatherData(weather: WeatherModel) {
        print(weather.conditionName)
        
        DispatchQueue.main.async {
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.temperatureLabel.text = weather.temperatureString
            self.cityLabel.text = weather.cityName
        }
    }
    
    
}

//MARK: - TextField Delegate
extension WeatherViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        print(searchTextField.text ?? "na")
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if  let city = searchTextField.text{
            weatherManager.fetchWeather(cityName: city)
        }
        
        searchTextField.text = ""
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""
        {
            return true
        }else{
            textField.placeholder = "Type something"
            return false
        }
    }
}

