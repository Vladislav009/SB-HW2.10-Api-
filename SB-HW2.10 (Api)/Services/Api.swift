//
//  Api.swift
//  SB-HW2.10 (Api)
//
//  Created by Vladislav Kulak on 11.08.2021.
//

import Foundation

class Api {
    static func routeGetWheather(latitude: Double, longtitude: Double) -> String {
        return "https://api.weather.yandex.ru/v2/forecast?lat=\(latitude)&lon=\(longtitude)"
    }
}
