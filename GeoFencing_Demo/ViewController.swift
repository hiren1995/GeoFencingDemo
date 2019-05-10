//
//  ViewController.swift
//  GeoFencing_Demo
//
//  Created by LogicalWings Mac on 27/11/18.
//  Copyright © 2018 LogicalWings Mac. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    let locationManager = CLLocationManager()
    
    let lat = 22.2603469
    let long = 73.1789746
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.requestAlwaysAuthorization()
        
        let geofenceRegionCenter = CLLocationCoordinate2DMake(lat, long)
        let geoFenceRegion = CLCircularRegion(center: geofenceRegionCenter, radius: 100, identifier: "unique")
        
        geoFenceRegion.notifyOnEntry = true
        //geoFenceRegion.notifyOnExit = true
        
        locationManager.startMonitoring(for: geoFenceRegion)
        
    }
}
