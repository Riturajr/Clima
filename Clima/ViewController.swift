//
//  ViewController.swift
//  Clima
//
//  Created by Rituraj R on 12/07/21.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var conditionImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var searchtextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchtextField.delegate = self
    }

    @IBAction func searchPressed(_ sender: UIButton) {
        searchtextField.endEditing(true)
        print(searchtextField.text!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchtextField.endEditing(true)
        print(searchtextField.text!)
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
        searchtextField.text = ""
    }
}

