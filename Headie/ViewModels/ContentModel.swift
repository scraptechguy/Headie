//
//  ContentModel.swift
//  Headie
//
//  Created by Rostislav Brož on 12/31/22.
//

import Foundation
import SwiftUI
import Combine
import CoreLocation
import MapKit

class ContentModel: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    // MARK: - Location
      
    var locationManager = CLLocationManager()

    @Published var authorizationState = CLAuthorizationStatus.notDetermined
    @Published var placemark: CLPlacemark?

    override init() {
      
        // Init method of NSObject
        super.init()

        // Make ContentModel the delegate of the location manager
        locationManager.delegate = self
      
    }

    // Request permission
    func requestGeolocationPermission() {
      
        locationManager.requestWhenInUseAuthorization()
      
    }

    // Publish degrees value on it's change
    var objectWillChange = PassthroughSubject<Void, Never>()
    var degrees: Double = .zero {
        didSet {
            objectWillChange.send()
        }
    }

    // MARK - Location Manager Delegate Methods

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
      
        authorizationState = locationManager.authorizationStatus

        if locationManager.authorizationStatus == .authorizedAlways || locationManager.authorizationStatus == .authorizedWhenInUse {
          
          locationManager.startUpdatingLocation()
          
        } else if locationManager.authorizationStatus == .denied {
          
          
          
        }
        
        if CLLocationManager.headingAvailable() {
            
            locationManager.startUpdatingHeading()
            
        }
      
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      
        let userLocation = locations.first
      
        if userLocation != nil {
          
          // Stop updating location after received once
          locationManager.stopUpdatingLocation()
          
          // Get the placemark of the user
          let geoCoder = CLGeocoder()
          
          geoCoder.reverseGeocodeLocation(userLocation!) { (placemarks, error) in
              
              // Check for errors
              if error == nil && placemarks != nil {
                  
                  self.placemark = placemarks?.first
                  
              }
          }
          
        }
      
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        
        self.degrees = -1 * newHeading.magneticHeading
        
    }
    
}
