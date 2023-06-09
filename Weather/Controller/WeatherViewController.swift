//
//  WeatherViewController.swift
//  Weather
//
//  Created by Anurag Chourasia on 08/06/23.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    @IBOutlet weak var searchLocationView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var weatherTypeLabel: UILabel!
    @IBOutlet weak var degreeLabel: UILabel!
    @IBOutlet weak var conditionImageView: UIImageView!
    
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchLocationView.layer.cornerRadius = 25
        locationNameLabel.font = UIFont(name: "Poppins-Medium", size: 30)
        weatherTypeLabel.font = UIFont(name: "Inter-Medium", size: 16)
        degreeLabel.font = UIFont(name: "Inter-Medium", size: 90)
        
        maxTempLabel.font = UIFont(name: "Inter-Medium", size: 12)
        minTempLabel.font = UIFont(name: "Inter-Medium", size: 12)
        feelsLikeLabel.font = UIFont(name: "Inter-Medium", size: 12)
        windSpeedLabel.font = UIFont(name: "Inter-Medium", size: 12)
        humidityLabel.font = UIFont(name: "Inter-Medium", size: 12)
        
        searchTextField.delegate = self
        
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        weatherManager.delegate = self
        searchTextField.delegate = self
    }
    

}
//MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate{
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        print(textField.text!)
    }
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        textField.endEditing(true)
//        return true
//    }
    
//    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
//        return true
//    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = searchTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
            weatherManager.fetchWeather(cityName: city)
        }
        
        searchTextField.text = ""
        
    }
}


//MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.degreeLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(named: weather.conditionName)
            self.weatherTypeLabel.text = weather.weatherType.capitalized
            self.locationNameLabel.text = weather.cityName
            
            self.maxTempLabel.text = String(weather.windString)
            self.minTempLabel.text = String(weather.feelsLikeString)
            self.feelsLikeLabel.text = String(weather.tempMinString)
            self.windSpeedLabel.text = String(weather.tempMaxString)
            self.humidityLabel.text = String(weather.humidityString)
            
            
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

//MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {
    
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

