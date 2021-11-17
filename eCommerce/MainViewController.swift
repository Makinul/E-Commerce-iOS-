//
//  MainViewController.swift
//  eCommerce
//
//  Created by Raven-Mac 2 on 9/11/21.
//

import UIKit
import Firebase

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // in your viewDidLoad or viewWillAppear
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "Something Else", style: .plain, target: nil, action: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Something Else"
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let currentUser = Auth.auth().currentUser
        let preferences = UserDefaults.standard
        
        if preferences.object(forKey: Constants.keyUserLoggedIn) == nil {
            self.performSegue(withIdentifier: Constants.segueToGoHome, sender: nil)
        } else {
            let userLoggedIn = preferences.bool(forKey: Constants.keyUserLoggedIn)
            
            if userLoggedIn {
                if currentUser == nil {
                    self.performSegue(withIdentifier: Constants.segueToGoLogin, sender: nil)
                } else {
                    self.performSegue(withIdentifier: Constants.segueToGoHome, sender: nil)
                }
            } else {
                self.performSegue(withIdentifier: Constants.segueToGoLogin, sender: nil)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}
