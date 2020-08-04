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
import GoogleSignIn

class GameViewController: UIViewController {
    
    let user: GIDGoogleUser? = nil
    
    @IBOutlet weak var globe: FLAnimatedImageView!
    
    @IBOutlet weak var distanceInput: UITextField!
    
    @IBOutlet weak var gameCodeInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let user: GIDGoogleUser? = appDelegate.USER
//        if(user == nil){
//            performSegue(withIdentifier: <#T##String#>, sender: <#T##Any?#>)
//        }
        
        self.navigationController?.isNavigationBarHidden = true;
    
        print("\(globe)")
        if let path =  Bundle.main.path(forResource: "globe", ofType: "gif") {
          if let data = NSData(contentsOfFile: path) {
            let gif = FLAnimatedImage(animatedGIFData: data as Data)
            globe.animatedImage = gif
          }
        }
        
        
    }


    
    @IBAction func startPressed(_ sender: Any) {
        let tagDistance = distanceInput.text!
        print(tagDistance)
        if (tagDistance != ""){
            if user != nil {
                let uid = user?.userID
                print (uid!)
                       
                let configuration = URLSessionConfiguration.default
                let session = URLSession(configuration: configuration)
                       
                let URLSTRING = "https://spacetag.vercel.app/api/game/create?creatorId=" + String(uid!) + "&tagDistance=" + tagDistance
                let url = URL(string: URLSTRING)!
                var request : URLRequest = URLRequest(url: url)
                request.httpMethod = "POST"
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.addValue("application/json", forHTTPHeaderField: "Accept")
                
                
                let dataTask = session.dataTask(with: url) { data,response,error in guard let httpResponse = response as? HTTPURLResponse, let receivedData = data
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
                
//                //let session = URLSession.shared
//                let task = session.dataTask(with: request) { (data, response, error) in
//
//                    if let error = error {
//                        // Handle HTTP request error
//                    } else if let data = data {
//                        print( "Got data back")
//
//                    } else {
//                        // Handle unexpected error
//                    }
//                }
                dataTask.resume()
                
            }
            performSegue(withIdentifier: "toGame", sender: sender)
        }
    }

    
    
    @IBAction func enterGamePressed(_ sender: Any) {
        print("need to join existing game")
        let gameCode = gameCodeInput.text!
        print(gameCode)
        if (gameCode != ""){
            if user != nil {
                let uid = user?.userID
                print (uid!)
                let configuration = URLSessionConfiguration.default
                let session = URLSession(configuration: configuration)
                let URLSTRING = "https://spacetag.vercel.app/api/game/join?playerId=" + String(uid!) + "&gameId=" + gameCode
                let url = URL(string: URLSTRING)!
                var request : URLRequest = URLRequest(url: url)
                request.httpMethod = "POST"
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.addValue("application/json", forHTTPHeaderField: "Accept")
                let dataTask = session.dataTask(with: url) { data,response,error in guard let httpResponse = response as? HTTPURLResponse, let receivedData = data
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
            performSegue(withIdentifier: "toExistingGame", sender: sender)
        }
    }
    
    
    


    
}
