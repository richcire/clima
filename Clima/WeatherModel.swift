//
//  WeatherModel.swift
//  Clima
//
//  Created by 연민석 on 4/10/26.
//  Copyright © 2026 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        default:
            return "cloud"
        }
    }
    
    

}
