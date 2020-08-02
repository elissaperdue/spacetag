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
      let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                        accessToken: authentication.accessToken)
      // ...
        
    Auth.auth().signIn(with: credential) { (authResult, error) in
      if let error = error {
        let authError = error as NSError
        /*if ( authError.code == AuthErrorCode.secondFactorRequired.rawValue) {
          // The user is a multi-factor user. Second factor challenge is required.
          let resolver = authError.userInfo[AuthErrorUserInfoMultiFactorResolverKey] as! MultiFactorResolver
          var displayNameString = ""
          for tmpFactorInfo in (resolver.hints) {
            displayNameString += tmpFactorInfo.displayName ?? ""
            displayNameString += " "
          }
          self.showTextInputPrompt(withMessage: "Select factor to sign in\n\(displayNameString)", completionBlock: { userPressedOK, displayName in
            var selectedHint: PhoneMultiFactorInfo?
            for tmpFactorInfo in resolver.hints {
              if (displayName == tmpFactorInfo.displayName) {
                selectedHint = tmpFactorInfo as? PhoneMultiFactorInfo
              }
            }
            PhoneAuthProvider.provider().verifyPhoneNumber(with: selectedHint!, uiDelegate: nil, multiFactorSession: resolver.session) { verificationID, error in
              if error != nil {
                print("Multi factor start sign in failed. Error: \(error.debugDescription)")
              } else {
                self.showTextInputPrompt(withMessage: "Verification code for \(selectedHint?.displayName ?? "")", completionBlock: { userPressedOK, verificationCode in
                  let credential: PhoneAuthCredential? = PhoneAuthProvider.provider().credential(withVerificationID: verificationID!, verificationCode: verificationCode!)
                  let assertion: MultiFactorAssertion? = PhoneMultiFactorGenerator.assertion(with: credential!)
                  resolver.resolveSignIn(with: assertion!) { authResult, error in
                    if error != nil {
                      print("Multi factor finanlize sign in failed. Error: \(error.debugDescription)")
                    } else {
                      self.navigationController?.popViewController(animated: true)
                    }
                  }
                })
              }
            }
          })
        } else {
          //self.showMessagePrompt(error.localizedDescription)
          return
        }*/
        // ...
        return
      }
      // User is signed in
      // ...
        
    //performSegue(withIdentifier: "signIn", sender: self)
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

