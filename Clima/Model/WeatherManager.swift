//
//  WeatherManager.swift
//  Clima
//
//  Created by Rituraj R on 14/07/21.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weathermanager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=cda1c2da726bbb5106ffce9951605696&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
     
        //1. Create a URL
        if let url = URL(string: urlString) {
        //2. Create URLSession
            let session = URLSession(configuration: .default)
        //3. Give the session a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }

            }
            
        //4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data)-> WeatherModel? {
        let decoder = JSONDecoder()
        do {
           let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let description = decodedData.weather[0].description
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp, condition: description)
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
