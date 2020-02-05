//
//  WeatherManager.swift
//  Clima
//
//  Created by Appala Naidu on 04/02/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=4245b4758713772af64cfa8f881dbd0a&units=metric"
    
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
            print("**Error - \(error!)")
        }
        
        if let safeData = data{
            
            let dataString = String(data: safeData, encoding: .utf8)
            print(dataString!)
        }
    }
}
