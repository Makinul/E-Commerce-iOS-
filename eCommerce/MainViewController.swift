//
//  ViewController.swift
//  eCommerce
//
//  Created by Raven-Mac 2 on 30/10/21.
//

import UIKit
import Firebase

class MainViewController: UIViewController {
    
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var handle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        do {
//            try Auth.auth().signOut()
//        } catch let error {
//            print("sign out failed: \(error)")
//        }
        
        print("Main view controller")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        handle = Auth.auth().addStateDidChangeListener { auth, user in
            
            if user == nil {
                
            } else {
                print(user)
                
                self.performSegue(withIdentifier: "goingToList", sender: nil)
                self.emailAddress.text = nil
                self.password.text = nil
            }
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    @IBAction func emailPasswordLogin(_ sender: UIButton) {
        guard let email = emailAddress.text else { return }
        guard let pass = password.text else { return }

        Auth.auth().signIn(withEmail: email, password: pass) { [weak self] authResult, error in
            guard let strongSelf = self else { return }

            if let error = error {
                let alert = UIAlertController(
                    title: "Sign In Failed",
                    message: error.localizedDescription,
                    preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: "OK", style: .default))
                strongSelf.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func signUp(_ sender: Any) {
        self.performSegue(withIdentifier: "goingSignup", sender: nil)
    }
}

