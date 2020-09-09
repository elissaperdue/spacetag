//
//  SigninViewController.swift
//  nav
//
//  Created by Zoe Vogelsang on 8/1/20.
//  Copyright © 2020 Elissa Perdue. All rights reserved.
//

import UIKit
import FirebaseCore
import Firebase
import GoogleSignIn
import FirebaseDatabase

class SigninViewController: UIViewController {
    
    @objc private func signIn() {
        performSegue(withIdentifier: "signIn", sender: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(signIn), name: NSNotification.Name("signedIn"), object: nil)
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        //automatically sign in user:
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        
        self.navigationController?.isNavigationBarHidden = true;
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var signInButton: GIDSignInButton! {
        didSet {
            signInButton.style = GIDSignInButtonStyle.wide
        }
    }
    
    //implement if we want a sign out button
//    @IBAction func didTapSignOut(_ sender: AnyObject) {
//      GIDSignIn.sharedInstance().signOut()
//    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
