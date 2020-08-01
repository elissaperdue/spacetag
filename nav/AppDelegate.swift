//
//  AppDelegate.swift
//  nav
//
//  Created by Elissa Perdue on 7/18/20.
//  Copyright © 2020 Elissa Perdue. All rights reserved.
//

import UIKit
import RadarSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, RadarDelegate {
    func didLog(message: String) {
        print("did sign in")
    }
    
    


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        Radar.initialize(publishableKey: "prj_live_pk_55fa7fc774958b757e21c798f2968e26b9dda806")
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


}

