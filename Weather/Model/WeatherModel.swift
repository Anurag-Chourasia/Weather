//
//  WeatherModel.swift
//  Weather
//
//  Created by Anurag Chourasia on 09/06/23.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    let weatherType: String
    
    let wind: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let humidity: Double
    
    var windString: String {    return String(format: "Wind Speed\n%.1f", wind)    }
    var feelsLikeString: String {    return String(format: "Feels Like\n%.1f°c", feels_like)    }
    var tempMinString: String {    return String(format: "Min Temp\n%.1f°c", temp_min)    }
    var tempMaxString: String {    return String(format: "Max Temp\n%.1f°c", temp_max)    }
    var humidityString: String {    return String(format: "Humidity\n%.0f", humidity)    }
    
    var temperatureString: String {    return String(format: "%.1f°c", temperature)    }
    
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloudBolt"
        case 300...321:
            return "cloudDrizzle"
        case 500...531:
            return "cloudRain"
        case 600...622:
            return "cloudSnow"
        case 701...781:
            return "cloudFog"
        case 800:
            return "sun"
        case 801...804:
            return "cloudBolt"
        default:
            return "cloud"
        }
    }
    
}
