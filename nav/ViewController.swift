//
//  ViewController.swift
//  nav
//
//  Created by Elissa Perdue on 7/18/20.
//  Copyright © 2020 Elissa Perdue. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager?
    
    
    @IBAction func startPressed(_ sender: Any) {
        performSegue(withIdentifier: "start", sender: nil)
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        


        view.backgroundColor = .gray
        // Do any additional setup after loading the view.
        //if starteverything.pressed
    
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    // do stuff
                }
            }
        }
    }


}

