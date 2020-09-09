
//
//  MapViewController.swift
//  nav
//
//  Created by Elissa Perdue on 8/1/20.
//  Copyright © 2020 Elissa Perdue. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import RadarSDK
@testable import nav

class MapViewController: UIViewController {

    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var addressLabel: UILabel!
    
    
    private var placesClient: GMSPlacesClient!

    override func viewDidLoad() {
        super.viewDidLoad()
        placesClient = GMSPlacesClient.shared()
   
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //curLoc will be modified to contain current locaiton of user
    var curLoc = LocationTag.self(name: "curLocation", latitude: 0.0, longitude: 0.0)
  

    // Add a UIButton in Interface Builder, and connect the action to this function.
    @IBAction func getCurrentPlace(_ sender: UIButton) {
     let placeFields = GMSPlaceField(rawValue:
       GMSPlaceField.name.rawValue | GMSPlaceField.formattedAddress.rawValue
     )!

        
     placesClient.findPlaceLikelihoodsFromCurrentLocation(withPlaceFields: placeFields) { [weak self] (placeLikelihoods, error) in
       guard let strongSelf = self else {
         return
       }

       guard error == nil else {
         print("Current place error: \(error?.localizedDescription ?? "")")
         return
       }

       guard let place = placeLikelihoods?.first?.place else {
         strongSelf.nameLabel.text = "No current place"
         strongSelf.addressLabel.text = ""
         return
       }
        print(place.coordinate)
       strongSelf.nameLabel.text = place.name
       strongSelf.addressLabel.text = place.formattedAddress
     
        
        Radar.trackOnce { (status: RadarStatus, location: CLLocation?, events: [RadarEvent]?, user: RadarUser?) in
               // do something with location, events, user
                 print("have location")
            //let loc = location?.coordinate.latitude
            self?.curLoc.latitude = location?.coordinate.latitude ?? 0
            self?.curLoc.longitude = location?.coordinate.longitude ?? 0
            print(self?.curLoc.latitude ?? 0);
            print(self?.curLoc.longitude ?? 0)
        
             }
        
        
     }
    
    }
    
    
    @IBAction func showMap(_ sender: Any) {
        
        let camera = GMSCameraPosition.camera(withLatitude: curLoc.latitude, longitude: curLoc.longitude, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: (self.view.frame), camera: camera)
        self.view.addSubview(mapView)

        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: curLoc.latitude, longitude: curLoc.longitude)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
        
        
    }
     
    @IBAction func tagPressed(_ sender: Any) {
        let newLoc = LocationTag(name: "compLoc", latitude: 0.0, longitude: 0.0)

        
        let distance = calculateDistance(compLocA: newLoc.latitude, compLocO: newLoc.longitude, curLocA: curLoc.latitude, curLocO: curLoc.longitude)
        
        print(distance)
        
        //hard coded game distance
        
        if(distance <= 50){
            print("Game Over!")
        }
    }
    
    
    func calculateDistance(compLocA: Double, compLocO: Double, curLocA: Double, curLocO: Double)->Double{
        
        var xComp = (compLocA-curLocA)
        var yComp = (compLocO-curLocO)
        xComp = xComp*xComp
        yComp = yComp*yComp
        var diff = xComp + yComp
        diff = sqrt(diff)
        return diff
    }
    

}
