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
    
    var user: GIDGoogleUser! = nil
    var USERID: String = ""
    
    @IBOutlet weak var globe: FLAnimatedImageView!
    @IBOutlet weak var distanceInput: UITextField!
    @IBOutlet weak var gameCodeInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        USERID = appDelegate.USERID
        
        if((USERID) == ""){
            print("___________________________________________________________________________________________________________________ ERROR user nil!_____________________________________________________________________________________________________________________________")
        }
        
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
            if ((USERID) != "" ){
                
//                let configuration = URLSessionConfiguration.default
//                let session = URLSession(configuration: configuration)
                
                let URLSTRING = "https://spacetag.vercel.app/api/game/create?creatorId=" + USERID + "&tagDistance=" + tagDistance
                let url = URL(string: URLSTRING)!
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                    if let error = error {
                        print("error: \(error)")
                    } else {
                        if let response = response as? HTTPURLResponse {
                            print("statusCode: \(response.statusCode)")
                        }
                        if let data = data, let dataString = String(data: data, encoding: .utf8) {
                            print("data: \(dataString)")
                        }
                    }
                }
                
                task.resume()
                performSegue(withIdentifier: "toGame", sender: sender)
            }
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
