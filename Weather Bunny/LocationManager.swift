//
//  LocationManager.swift
//  Weather Bunny
//
//  Created by Bhaskara Padala on 11/27/24.
//

import Foundation
import CoreLocation

// Your imports remain the same

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()

    @Published var location: CLLocationCoordinate2D?
    @Published var isLoading = false

    override init() {
        super.init()
        manager.delegate = self

        // Check and request proper permissions
        if manager.authorizationStatus == .notDetermined {
            manager.requestWhenInUseAuthorization()
        }

        // Start location updates initially to fetch immediately if authorized
        if manager.authorizationStatus == .authorizedAlways ||
           manager.authorizationStatus == .authorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }

    func requestLocation() {
        isLoading = true
        manager.requestWhenInUseAuthorization() // Use Always if necessary
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Log for debugging purposes
        if let updatedLocation = locations.first?.coordinate {
            print("Location updated: \(updatedLocation)")
            location = updatedLocation
            isLoading = false
            manager.stopUpdatingLocation() // Conserve battery
            // Ensure the welcomeShown is updated in ContentView based on this
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error fetching location", error)
        isLoading = false
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            // Request location again if authorized
            manager.requestLocation()
        default:
            // Log unauthorized attempt
            print("App not authorized to access location")
            break
        }
    }
}


// Implementing locationManagerDidChangeAuthorization to handle runtime changes in authorization status.
/*func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    // Delegate method called when the location is updated
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.location = location
        locationManager.stopUpdatingLocation()
    }
    
    // Delegate method called when an error occurs in location updates
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
*/
