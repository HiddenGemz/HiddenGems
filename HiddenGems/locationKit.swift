//
//  LocationKit.swift
//  HiddenGems
//
//  Created by Daniel Ley on 7/10/16.
//  Copyright © 2016 daniel. All rights reserved.
//

import Foundation
import AddressBook
import CoreLocation
import MapKit

//public protocol locationKitDelegate {
//    func locationKit(locationKit:locationKit)
//}

public class locationKit: NSObject, CLLocationManagerDelegate {
    
    // MARK: Properties
//    public var delegate: LocationKitDelegate?
    
    var locationManager: CLLocationManager = CLLocationManager()
    //the number of meters that the device must move for a update of the screen
    let kDistanceFilter:Double = 100.0
    var coords: CLLocationCoordinate2D?
    var currentLatitude: CLLocationDistance?
    var currentLongitude: CLLocationDistance?
    var verticalAccuracy: CLLocationAccuracy?
    var horizontalAccuracy: CLLocationAccuracy?
    var currentLocation: CLLocation?
    
    
    public override init() {
        
        super.init()
        
        locationManager.delegate = self
        // Authorize location usage from user
        locationManager.requestWhenInUseAuthorization()
        // Set accuracy level
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // Set map Distance Filter, the number of meters that the device must move for a update of the screen
        locationManager.distanceFilter = kDistanceFilter
        //locationManager.distanceFilter = kCLDistanceFilterNone
        
        locationManager.startUpdatingLocation()
        
        
        //delegate?.locationKit(self)
    }
    
    // MARK: CLLocationManagerDelegate Methods
    public func locationManager(manager: CLLocationManager, didUpdateLocation location: CLLocation) {
        // Handle Location Updates Here
        self.currentLocation = location
        self.currentLatitude = location.coordinate.latitude
        self.currentLongitude = location.coordinate.longitude
    }
    
    public func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        // Handle Errors Here
    }
    
    public func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        // App may no longer be authorized to obtain location
        //information. Check status here and respond accordingly.
    }
    
}
