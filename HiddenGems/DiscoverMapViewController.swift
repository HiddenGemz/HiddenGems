//
//  DiscoverMapViewController.swift
//  HiddenGems
//
//  Created by Daniel Ley on 7/7/16.
//  Copyright © 2016 daniel. All rights reserved.
//

import UIKit
import GoogleMaps

class DiscoverMapViewController: UIViewController {

    // MARK: Properties
    var locationManager = CLLocationManager()
    var mapView:GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Core Location Manager asks for GPS location
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        mapView = GMSMapView(frame: self.view.frame)
        self.view.addSubview(mapView)
        self.mapView.myLocationEnabled = true
        self.mapView.settings.myLocationButton = true
        //self.mapView.delegate=self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension DiscoverMapViewController : CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse {
            locationManager.startUpdatingLocation()
            print("Started Updating location")
            // self.mapView.myLocationEnabled = true
            //self.mapView.settings.myLocationButton = true
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            mapView?.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
            //locationManager.stopUpdatingLocation()
        }
    }
}
