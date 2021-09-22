//
//  JSONDecoder.swift
//  yumemiWeatherApp
//
//  Created by Juri Ohto on 2021/09/23.
//

import Foundation
import YumemiWeather

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






//{"max_temp":21,"date":"2020-04-01T12:00:00+09:00","min_temp":17,"weather":"cloudy"}



//let decoder = JSONDecoder()
//
//let weatherInfo = try! decoder.decode(WeatherInformation.self, from: )
