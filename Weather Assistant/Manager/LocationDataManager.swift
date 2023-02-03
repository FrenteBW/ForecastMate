//
//  LocationDataManager.swift
//  Weather Assistant
//
//  Created by 안병욱의 mac on 2022/11/29.
//

import Foundation
import CoreLocation

class LocationDataManager : NSObject, ObservableObject, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    @Published var authorizationStatus: CLAuthorizationStatus?
    
    var latitude: Double {
        locationManager.location?.coordinate.latitude ?? 0.0
    }
    var longitude: Double {
        locationManager.location?.coordinate.longitude ?? 0.0
    }
    
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:  // Location services are available.
            authorizationStatus = .authorizedWhenInUse
            locationManager.requestLocation()
            break
            
        case .restricted:  // Location services currently unavailable.
            authorizationStatus = .restricted
            break
            
        case .denied:  // Location services currently unavailable.
            authorizationStatus = .denied
            break
            
        case .notDetermined:        // Authorization not determined yet.
            authorizationStatus = .notDetermined
            manager.requestWhenInUseAuthorization()
            break
            
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error.localizedDescription)")
    }
    
    
}
