//
//  NetworkManager.swift
//  SB-HW2.10 (Api)
//
//  Created by Vladislav Kulak on 10.08.2021.
//

import Foundation
import Alamofire


class NetworkManager {
    static let share = NetworkManager()
    
    public var longtitude = 0.0
    public var latitude = 0.0
    
    private let apiKey = "d60aa43f-8443-4e75-afa1-d4e07566b699"
    
    private init(){}
    
    func fetchData(completion: @escaping(Weather) -> ()) {
        let url = Api.routeGetWheather(latitude: latitude, longtitude: longtitude)
        print(url)
        
        let headers: HTTPHeaders = [
            "X-Yandex-API-Key": apiKey
        ]
        
        AF.request(url, method: .get, headers: headers)
            .validate()
            .responseDecodable(of: Weather.self) { (response) in
                switch response.result {
                case .success(_):
                    guard let weather = response.value else { return }
                    
                    let currentWeather = Weather(
                        now: weather.now,
                        nowDt: weather.nowDt,
                        info: weather.info,
                        geoObject: weather.geoObject,
                        yesterday: weather.yesterday,
                        fact: weather.fact,
                        forecasts: weather.forecasts
                    )
                    
                    DispatchQueue.main.async {
                        completion(currentWeather)
                    }
                    
                case .failure(_):
                    print(response.error as Any)
                }
            }
    }
}
