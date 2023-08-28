//
//  ViewModel.swift
//  WeatherApp
//
//  Created by midDeveloper on 28.08.2023.
//

import Foundation
import Alamofire


class WeatherViewModel {
    
    
    func getWeatherData(city: String,  completion: @escaping ([Result]?,Error?) -> Void) {
        let url = URL(string: "https://api.collectapi.com/weather/getWeather?data.lang=tr&data.city=\(city)")!
        let authToken = "04yiLPdjkTJW2Ld8JZqYQf:3wAFbKO3a5zmCTknRcMFAm"
        let headers: HTTPHeaders = [
            "Authorization": "apikey \(authToken)",
            "content-type": "application/json"
        ]
        
        AF.request(url, method: .get, headers: headers).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let weather = try JSONDecoder().decode(Weather.self, from: data)
                    completion(weather.result,nil)
                } catch {
                    // error
                    completion(nil,"parsing error" as? Error)
                }
            case .failure(let error):
                // error
                completion(nil,error)
                print("error \(error)")
            }
        }
    }


    
}



