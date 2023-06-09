//
//  WeatherData.swift
//  Weather
//
//  Created by Anurag Chourasia on 09/06/23.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    let wind : wind
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let humidity: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}

struct wind: Codable {
  let speed: Double
}
