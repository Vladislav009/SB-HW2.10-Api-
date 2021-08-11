//
//  ViewController.swift
//  SB-HW2.10 (Api)
//
//  Created by Vladislav Kulak on 06.08.2021.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var temlLabel: UILabel!
    @IBOutlet weak var feelLable: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var speedWindLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let locationManager = CLLocationManager()
    let networkManager = NetworkManager.share
    
    
    private let apiKey = "d60aa43f-8443-4e75-afa1-d4e07566b699"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        location()
    }
}

// MARK: - Get location  user

extension ViewController {
    private func location(){
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print(locValue)
        networkManager.latitude = locValue.latitude
        networkManager.longtitude = locValue.longitude
        
        networkManager.fetchData()
    }
    
}

// MARK: - API handler

extension ViewController {
    
    func network() {
//        guard let url = URL(string: "https://api.weather.yandex.ru/v2/forecast?lat=\(Coordinate.latitude)&lon=\(Coordinate.longtitude)") else { return }
//
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.setValue(apiKey, forHTTPHeaderField: "X-Yandex-API-Key")
//
//        URLSession.shared.dataTask(with: request) { (data, response, error) in
//            guard let data = data else {
//                print(error?.localizedDescription ?? "No error descriprion")
//                return
//            }
//            do {
//                let weather = try JSONDecoder().decode(Weather.self, from: data)
//                DispatchQueue.main.sync {
//                    self.temlLabel.text = "\(weather.fact?.temp ?? 0)°"
//                    self.feelLable.text = "Ощущается как \(weather.fact?.feels_like ?? 0)°"
//                    self.speedWindLabel.text = "Скорость ветра \(weather.fact?.wind_speed ?? 0) м/с"
//                    self.pressureLabel.text = "Давление: \(weather.fact?.pressure_mm ?? 0) мм.рт.ст"
//                }
//
//                self.getIcon(condition: Icon(rawValue: weather.fact?.condition ?? "clear") ?? .clear)
//
//            } catch let error {
//                print(error)
//            }
//        }.resume()
         

        
    }
    
    private func getIcon(condition: Icon) {
        DispatchQueue.main.async {
            switch condition {
            
            case .clear:
                self.iconImage.image = UIImage(systemName: "sun.min")
            case .cloudy:
                self.iconImage.image = UIImage(systemName: "cloud.sun")
            case .overcast:
                self.iconImage.image = UIImage(systemName: "cloud")
            case .drizzle:
                self.iconImage.image = UIImage(systemName: "cloud.drizzle")
            case .rain:
                self.iconImage.image = UIImage(systemName: "cloud.rain")
            case .showers:
                self.iconImage.image = UIImage(systemName: "cloud.heavyrain")
            case .snow:
                self.iconImage.image = UIImage(systemName: "cloud.snow")
            case .hail:
                self.iconImage.image = UIImage(systemName: "cloud.hail")
            case .thunderstorm:
                self.iconImage.image = UIImage(systemName: "cloud.bolt.rain")
            }
            
            self.activityIndicator.stopAnimating()
        }
    }
}

// MARK: - Structure

struct Coordinate {
    static var longtitude = 0.0
    static var latitude = 0.0
}



