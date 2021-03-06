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
    
    var forecast: [Forecast] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        location()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailWeatherTVC = segue.destination as? DetailWeatherTableViewController else { return }
        
        detailWeatherTVC.forecasts = forecast
    }
    
    @IBAction func showDetailAction(_ sender: Any) {
        performSegue(withIdentifier: "showDetail", sender: nil)
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
        
        fetchData()
    }
    
}

// MARK: - API handler

extension ViewController {
    
    private func fetchData() {
        networkManager.fetchData() {
            currentWeather in
            self.temlLabel.text = "\(currentWeather.fact.temp )??"
            self.feelLable.text = "?????????????????? ?????? \(currentWeather.fact.feelsLike)??"
            self.speedWindLabel.text = "???????????????? ?????????? \(currentWeather.fact.windSpeed) ??/??"
            self.pressureLabel.text = "????????????????: \(currentWeather.fact.pressureMm) ????.????.????"
            self.getIcon(condition: Icon(rawValue: currentWeather.fact.condition.rawValue) ?? .clear)
            self.forecast = currentWeather.forecasts
            
            self.title = currentWeather.geoObject.province?.name
        }
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



