//
//  WeatherManager.swift
//  Clima
//
//  Created by minseok yeon on 4/8/26.
//  Copyright © 2026 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherURL = "https://dummyurl.org"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
    }
    
    func performRequest(urlString: String) {
        if let url = URL(string:urlString){
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url, completionHandler: handle(data:response:error:))
            
            task.resume()
        }
    }
    
    func handle(data: Data?, response: URLResponse?, error: Error?) {
        if let error = error {
            print(error)
            print(error.localizedDescription)
            return
        }
        
        if let safeData = data {
            if let dataString = String(data: safeData, encoding: .utf8) {
                print(dataString)
            }

        }
        
    }
}
