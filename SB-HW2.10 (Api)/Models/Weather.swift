//
//  Weather.swift
//  SB-HW2.10 (Api)
//
//  Created by Vladislav Kulak on 06.08.2021.
//

import Foundation

struct Weather: Decodable {
    let now: Int?
    let now_dt: String?
    let info: Info?
    let fact: Fact?
    
    init(now: Int, now_dt: String, info: Info, fact: Fact){
        self.now = now
        self.now_dt = now_dt
        self.info = info
        self.fact = fact
        
    }
    
    init(weatherData: [String: Any]) {
        now = weatherData["now"] as? Int ?? 0
        now_dt = weatherData["now_dt"] as? String ?? ""
        info = weatherData["info"] as? Info
        fact = weatherData["fact"] as? Fact
    }
    
    static func getWeather(from value: Any) -> Weather {
        guard let weatherData = value as? [String: Any] else { return
            Weather(
                now: 0, now_dt: "",
                info: Info(lat: 0.0, lon: 0.0, url: ""),
                fact: Fact(temp: 0, feels_like: 0, icon: "", condition: "", wind_speed: 0.0, pressure_mm: 0)
            )
            
        }
        return Weather(weatherData: weatherData)
    }
    
}

struct Info:Decodable {
    let lat: Double?
    let lon: Double?
    let url: String?
    
    init(lat: Double, lon: Double, url: String){
        self.lat = lat
        self.lon = lon
        self.url = url
    }
    
    init(infoData: [String: Any]) {
        lat = infoData["lat"] as? Double ?? 0.0
        lon = infoData["lat"] as? Double ?? 0.0
        url = infoData["url"] as? String ?? ""
        
    }
}

struct Fact: Decodable {
    let temp: Int?
    let feels_like: Int?
    let icon: String?
    let condition: String?
    let wind_speed: Double?
    let pressure_mm: Int?
    
    init(temp: Int, feels_like: Int, icon: String, condition: String, wind_speed: Double, pressure_mm: Int){
        self.temp = temp
        self.feels_like = feels_like
        self.icon = icon
        self.condition = condition
        self.wind_speed = wind_speed
        self.pressure_mm = pressure_mm
    }
    
    init(factData: [String: Any]) {
        temp = factData["temp"] as? Int ?? 0
        feels_like = factData["feels_like"] as? Int ?? 0
        icon = factData["icon"] as? String ?? ""
        condition = factData["condition"] as? String ?? ""
        wind_speed = factData["wind_speed"] as? Double ?? 0.0
        pressure_mm = factData["pressure_mm"] as? Int ?? 0
    }
}

enum Icon: String {
    case clear
    case cloudy
    case overcast
    case drizzle
    case rain
    case showers
    case snow
    case hail
    case thunderstorm
}
