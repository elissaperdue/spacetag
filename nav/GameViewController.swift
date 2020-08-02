//
//  GameViewController.swift
//  nav
//
//  Created by Elissa Perdue on 8/1/20.
//  Copyright © 2020 Elissa Perdue. All rights reserved.
//

import UIKit
import RadarSDK
import ImageIO
import FLAnimatedImage

class GameViewController: UIViewController {
    
    @IBOutlet weak var globe: FLAnimatedImageView!
    
    
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
    
    @IBAction func startPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "toGame", sender: sender)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.navigationController?.isNavigationBarHidden = true;
    
        print("\(globe)")
        if let path =  Bundle.main.path(forResource: "globe", ofType: "gif") {
          if let data = NSData(contentsOfFile: path) {
            let gif = FLAnimatedImage(animatedGIFData: data as Data)
            globe.animatedImage = gif
          }
        }
    }
    
}
