//
//  DiscoverMapViewController.swift
//  HiddenGems
//
//  Created by Daniel Ley on 7/7/16.
//  Copyright © 2016 daniel. All rights reserved.
//

import UIKit
import MapKit

class DiscoverMapViewController: UIViewController, CLLocationManagerDelegate {

    // MARK: Properties
    @IBOutlet weak var mapView: MKMapView!
    var locManager = CLLocationManager()
    var latitude:Double = 0.0
    var longitude:Double = 0.0
    let regionRadius: CLLocationDistance = 1000
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Core Location Manager asks for GPS location
        locManager.delegate = self
        locManager.desiredAccuracy = kCLLocationAccuracyBest
        locManager.requestWhenInUseAuthorization()
        locManager.startMonitoringSignificantLocationChanges()

        //let initialLocation = CLLocation(latitude: latitude, longitude: longitude)
        //centerMapOnLocation(initialLocation)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: Helper methods
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        print(coordinateRegion)
        mapView.setRegion(coordinateRegion, animated: true)
    }

}
