//
//  WeatherManager.swift
//  Clima
//
//  Created by Appala Naidu on 04/02/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherURL = "http://api.openweathermap.org/data/2.5/weather?appid=4245b4758713772af64cfa8f881dbd0a&units=metric"
    
    func fetchWeather(cityName : String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        
        performRequest(urlString: urlString)
    }

    func performRequest(urlString : String)  {
        //CREATE URL
        
        if let url = URL(string: urlString)
        {
            //CREATE URLSESSION
            let session = URLSession(configuration: .default)
            
            //GIVE THE SESSION TO TASK
            let task = session.dataTask(with: url, completionHandler: <#T##(Data?, URLResponse?, Error?) -> Void#>)
            
            //START THE TASK
            task.resume()
        }
    
    }
    
    func handle (data:Data?, ursSession:URLSession?, error:Error?)
           {
               
           }
}
