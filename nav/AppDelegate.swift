//
//  AppDelegate.swift
//  nav
//
//  Created by Elissa Perdue on 7/18/20.
//  Copyright © 2020 Elissa Perdue. All rights reserved.
//

import UIKit
import RadarSDK
import FirebaseCore
import Firebase
import FirebaseDatabase
import GoogleSignIn
import GoogleMaps
import GooglePlaces
import FirebaseAuth

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate, RadarDelegate {
    
    var window: UIWindow?
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
      // ...
      if let error = error {
        // ...
        return
      }

      guard let authentication = user.authentication else { return }
        
        print("AUTHENTICATION ID TOKEN : __________________________________________________________________________________________________________________________________________________")
        print( authentication.idToken )
      let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                        accessToken: authentication.accessToken)
      // ...
        
    Auth.auth().signIn(with: credential) { (authResult, error) in
      if let error = error {
        let authError = error as NSError

        // ...
        return
      }
      // User is signed in
      // ...
        
    //performSegue(withIdentifier: "signIn", sender: self)
        let user = Auth.auth().currentUser
        print("UID : __________________________________________________________________________________________________________________________________________________")
        
        if let user = user {
            let uid = user.uid
            print (uid)
            
            let configuration = URLSessionConfiguration.default
            let session = URLSession(configuration: configuration)
            
            let URLSTRING = "https://xn--dr8h.vercel.app/api/game/create?creatorId=" + String(uid) + "&tagDistance=1000"
            let url = URL(string: URLSTRING)!
            var request : URLRequest = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            let dataTask = session.dataTask(with: url) { data,response,error in
               guard let httpResponse = response as? HTTPURLResponse, let receivedData = data
               else {
                  print("error: not a valid http response")
                  return
               }
               switch (httpResponse.statusCode) {
                  case 200: //success response.
                     break
                  case 400:
                     break
                  default:
                     break
               }
            }
            dataTask.resume()
        }
    }
        
    
    }

    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    
    
    
    
    
    func didLog(message: String) {
        print("did sign in")
    }
    
    


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
        [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        GMSServices.provideAPIKey("AIzaSyBdUT09kUbC5uTauXy0FRoT3HxvswVen2E")
        GMSPlacesClient.provideAPIKey("AIzaSyBdUT09kUbC5uTauXy0FRoT3HxvswVen2E")

        FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        
        Radar.initialize(publishableKey: "prj_test_pk_6f9f856ba23b59a7b018ae2766585ca4fd049ef0")
        Radar.setDelegate(self)
        print("radar initialized")
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func didReceiveEvents(_ events: [RadarEvent], user: RadarUser) {
       // do something with events, user
        print("received RAdar Event")
     }

     func didUpdateLocation(_ location: CLLocation, user: RadarUser) {
       // do something with location, user
        print("locationUpdated")
     }

     func didUpdateClientLocation(_ location: CLLocation, stopped: Bool, source: RadarLocationSource) {

       // do something with location, stopped, source
     }

    func didFail(status: RadarStatus) {
       // do something with status
     }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])
      -> Bool {
      return GIDSignIn.sharedInstance().handle(url)
    }
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }


}

