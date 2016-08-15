//
//  LocationManager.swift
//  HiddenGems
//
//  Created by Daniel Ley on 8/4/16.
//  Copyright © 2016 daniel. All rights reserved.
//

import Foundation
import CoreLocation
import GoogleMaps

//the number of meters that the device must move for a update of the screen
let kDistanceFilter:Double = 5.0

class LocationManager: NSObject {
    
    let locationManager = CLLocationManager()
    var coords: CLLocationCoordinate2D?
    var currentLatitude: CLLocationDegrees
    var currentLongitude: CLLocationDegrees
    var currentAddress: String?
    var currentLocation: CLLocation?
    
    override init() {
        
        currentLatitude = 0.0
        currentLongitude = 0.0
        super.init()
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kDistanceFilter
    }
    
    func reverseGeocodeCoordinate(coordinate: CLLocationCoordinate2D) {
        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            if let address = response?.firstResult() {
                let lines = address.lines! as [String]
                //print(lines.joinWithSeparator("\n"))
                self.currentAddress = lines.joinWithSeparator("\n")
            }
        }
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse {
            locationManager.startUpdatingLocation()
            print("Started Updating location")
            // self.mapView.myLocationEnabled = true
            //self.mapView.settings.myLocationButton = true
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.first != nil {
            //print("Updating location")
            if let location:CLLocationCoordinate2D = manager.location!.coordinate {
                //print("\(location.latitude)\(location.longitude)")
                reverseGeocodeCoordinate(location)
                currentLongitude = location.longitude
                currentLatitude = location.latitude
            }
            
            //locationManager.stopUpdatingLocation()
        }
        
    }
    
}


