//
//  GameViewController.swift
//  nav
//
//  Created by Elissa Perdue on 8/1/20.
//  Copyright © 2020 Elissa Perdue. All rights reserved.
//

import UIKit
import RadarSDK

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func activateRadar(_ sender: Any) {
        
        let userID = "abc";

        Radar.setUserId(userID)

        Radar.setDescription("test user")

        
        Radar.startTracking(trackingOptions: RadarTrackingOptions.continuous)
        print("user radar should be activated");
        
        let tripOptions = RadarTripOptions(externalId: "299")
        tripOptions.destinationGeofenceTag = "store"
        tripOptions.destinationGeofenceExternalId = "123"
        tripOptions.mode = .foot
        tripOptions.metadata = [
          "Customer Name": "Zoe",
        ]
        Radar.startTrip(options: tripOptions)
        Radar.startTracking(trackingOptions: .continuous)
        
    }
    
    @IBAction func stopRadar(_ sender: Any) {
        Radar.trackOnce { (status: RadarStatus, location: CLLocation?, events: [RadarEvent]?, user: RadarUser?) in
          // do something with location, events, user
            print("have location")
            let loc = location?.coordinate
            print(loc)
        }
        
        //Radar.stopTracking()
        print("tracklocation")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
