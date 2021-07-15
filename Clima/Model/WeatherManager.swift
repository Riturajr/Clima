//
//  WeatherManager.swift
//  Clima
//
//  Created by Rituraj R on 14/07/21.
//

import Foundation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=cda1c2da726bbb5106ffce9951605696&units=metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
     
        //1. Create a URL
        if let url = URL(string: urlString) {
        //2. Create URLSession
            let session = URLSession(configuration: .default)
        //3. Give the session a task
        let task = session.dataTask(with: url, completionHandler: handle(data: response: error: ))
            
        //4. Start the task
            task.resume()
        }
    }
    
    func handle(data: Data?, response: URLResponse?, error: Error?) {
        if error != nil {
            print(error!)
            return
        }
        if let safeData = data {
            let dataString = String(data: safeData, encoding: .utf8)
            print(dataString)
        }
    }
}
