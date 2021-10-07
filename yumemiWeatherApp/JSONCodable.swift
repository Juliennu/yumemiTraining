//
//  JSONDecoder.swift
//  yumemiWeatherApp
//
//  Created by Juri Ohto on 2021/09/23.
//

import Foundation

struct WeatherInformation: Encodable {
    let area: String
    let date: String
}

struct WeatherData: Decodable {
    let weather: String
    let maxTemp: Int
    let minTemp: Int
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case weather
        case maxTemp = "max_temp"
        case minTemp = "min_temp"
        case date
    }
}

