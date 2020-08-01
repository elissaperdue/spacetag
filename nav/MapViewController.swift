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


class MapViewController: UIViewController {

    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var addressLabel: UILabel!
    
    private var placesClient: GMSPlacesClient!

    override func viewDidLoad() {
        super.viewDidLoad()
        placesClient = GMSPlacesClient.shared()
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        /*let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        self.view.addSubview(mapView)

        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView*/
        // Do any additional setup after loading the view.
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    var long = 0.0;
    var lat = 0.0;

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
            let loc = location?.coordinate.latitude
            print(loc ?? 0.0)
            self?.lat = location?.coordinate.latitude as! Double
            self?.long = location?.coordinate.longitude as! Double
            print(self?.lat ?? 0.0)
            print(self?.long ?? 0.0)
            //strongSelf.nameLabel.text = place.name
            //strongSelf.nameLabel.text = location?.coordinate.latitude
            //strongSelf.nameLabel.text = location?.coordinate.latitude
                //nameLabel.text = location?.coordinate.longitude
             }
        
        
     }
    
    }
    
    
    @IBAction func showMap(_ sender: Any) {
        
        let camera = GMSCameraPosition.camera(withLatitude: self.lat, longitude: self.long, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: (self.view.frame), camera: camera)
        self.view.addSubview(mapView)

        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: self.lat, longitude: self.long)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
        
        
    }

}
