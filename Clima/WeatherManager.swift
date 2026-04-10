//
//  WeatherManager.swift
//  Clima
//
//  Created by minseok yeon on 4/8/26.
//  Copyright © 2026 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(_: Error)
}

struct WeatherManager {
    let weatherURL = "https://dummyurl.org"
    
    var delegate: WeatherManagerDelegate?

    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }

    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)

            let task = session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    self.delegate?.didFailWithError(error)
                    return
                }

                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }

                }
            }

            task.resume()
        }
    }

    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let jsonDecoder = JSONDecoder()
        do {
            let decodedData = try jsonDecoder.decode(
                WeatherData.self,
                from: weatherData
            )
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name

            let weather = WeatherModel(
                conditionId: id,
                cityName: name,
                temperature: temp
            )
            return weather
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }

    }

}
