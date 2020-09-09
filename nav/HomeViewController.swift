//
//  HomeViewController.swift
//  nav
//
//  Created by Zoe Vogelsang on 8/1/20.
//  Copyright © 2020 Elissa Perdue. All rights reserved.
//

import UIKit
import ImageIO
import FLAnimatedImage

class HomeViewController: UIViewController {
    
    @IBOutlet weak var globe: FLAnimatedImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
        print("\(globe)")
        if let path =  Bundle.main.path(forResource: "globe", ofType: "gif") {
          if let data = NSData(contentsOfFile: path) {
            let gif = FLAnimatedImage(animatedGIFData: data as Data)
            globe.animatedImage = gif
          }
        }

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

}
