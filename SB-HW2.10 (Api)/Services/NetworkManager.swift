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
    
    func fetchData() {
        let url = "https://api.weather.yandex.ru/v2/forecast?lat=\(latitude)&lon=\(longtitude)"
        
        let headers: HTTPHeaders = [
            "X-Yandex-API-Key": apiKey
        ]
        
        AF.request(url, method: .get, headers: headers)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                     let test = Weather.getWeather(from: value)
                    print(test)
                    //self.courses = Course.getCourses(from: value)
                case .failure(let error):
                    print(error)
                }
                
            }
    }
    
    
    
}
