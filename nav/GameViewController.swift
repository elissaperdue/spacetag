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
    
    @IBOutlet weak var distanceInput: UITextField!
    
    @IBOutlet weak var gameCodeInput: UITextField!
    
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


    
    @IBAction func startPressed(_ sender: Any) {
        
        print("need to create new game")
        var tagDistance = distanceInput.text!
        
        //spacetag.vercel.app/api/game/create?creatorId={player.uuid}&tagDistance={numberInFeet}
        
        
        performSegue(withIdentifier: "toGame", sender: sender)
    }

    
    
    @IBAction func enterGamePressed(_ sender: Any) {
        
        print("need to join existing game")
        var gameCode = gameCodeInput.text!
        //spacetag.vercel.app/api/game/join?playerId={playerWhosJoining}&gameId={shortGameId}
        
        performSegue(withIdentifier: "toExistingGame", sender: sender)
        
    }
    
    
    


    
}
