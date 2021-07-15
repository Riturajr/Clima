//
//  ViewController.swift
//  Clima
//
//  Created by Rituraj R on 12/07/21.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate {
    
    @IBOutlet weak var conditionImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchtextField: UITextField!
    @IBOutlet weak var conditionLabel: UILabel!
   
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherManager.delegate = self
        searchtextField.delegate = self
    }

    @IBAction func searchPressed(_ sender: UIButton) {
        searchtextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchtextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type Something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchtextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        
        searchtextField.text = ""
    }
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImage.image = UIImage(systemName: weather.conditionName)
            self.conditionLabel.text = weather.condition
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

