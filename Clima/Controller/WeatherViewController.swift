//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    let locationManager = CLLocationManager()
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    let WEATHER_API_KEY = "4245b4758713772af64cfa8f881dbd0a"
    
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        weatherManager.delegateUpdateWeatherData = self
        searchTextField.delegate = self
    }

    @IBAction func onClickSearch(_ sender: UIButton) {
        searchTextField.endEditing(true)
        print(searchTextField.text ?? "na")
    }
    
    
    @IBAction func onClickLocation(_ sender: UIButton) {
        locationManager.requestLocation()
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
            //self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.temperatureLabel.text = weather.temperatureString
            self.cityLabel.text = weather.cityName
            self.weatherManager.fetchImaage(iconName: String(weather.icon), view: self.conditionImageView)
            
        }
    }
    
//    func didUpdateIcon(imageData: Data) {
//        DispatchQueue.main.async {
//            self.conditionImageView.image = UIImage(data: imageData)
//        }
//    }
    
    
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

//MARK: - Location Delegate
extension WeatherViewController : CLLocationManagerDelegate
{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("location Delegate")
        if let location = locations.last {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            print("\(latitude) - \(longitude)")
            
            weatherManager.fetchWeather(latitude: latitude, longitude: longitude)
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //
        print("Location error :- \(error)")
    }
    
    
}

