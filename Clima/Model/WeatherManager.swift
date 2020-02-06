//
//  WeatherManager.swift
//  Clima
//
//  Created by Appala Naidu on 04/02/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol UpdateWeatherDataDelegate {
    func didUpdateWeatherData(weather : WeatherModel)
    func didFailWithError(_ error : Error!)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=4245b4758713772af64cfa8f881dbd0a&units=metric"
    
    var delegateUpdateWeatherData : UpdateWeatherDataDelegate?
    
    
    func fetchWeather(cityName : String) {
        let urlString = "\(weatherURL)&q=\(cityName)"        
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString : String)  {
        //1. CREATE URL
        
        if let url = URL(string: urlString)
        {
            //2. CREATE URLSESSION
            let session = URLSession(configuration: .default)
            
            //3. GIVE THE SESSION TO TASK
            let task = session.dataTask(with: url, completionHandler: handle(data:  response:  error: ))
            
            //4. START THE TASK
            task.resume()
        }
        
    }
    
    func handle (data:Data?, response:URLResponse?, error:Error?)
    {
        if error != nil {
            
            delegateUpdateWeatherData?.didFailWithError(error)
            print("**Error - \(error!)")
        }
        
        if let safeData = data{
            if let weather = self.parseJSON(weatherData: safeData) {
                self.delegateUpdateWeatherData?.didUpdateWeatherData(weather: weather)
            }
        }
    }
    
    func parseJSON(weatherData : Data) -> WeatherModel? {
        
        let decoder = JSONDecoder()
       
        
        do{
            
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temperature = decodedData.main.temp
            let name = decodedData.name
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temperature)
            
            
            return weather
            
        }catch{
            delegateUpdateWeatherData?.didFailWithError(error)
            print(error)
            return nil
        }
        
        
    }
    
    func fetchWeather(latitude : CLLocationDegrees, longitude : CLLocationDegrees)  {
         let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        print(urlString)
               performRequest(urlString: urlString)
    }
    
}
