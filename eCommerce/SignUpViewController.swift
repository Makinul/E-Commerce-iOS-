//
//  SignUpViewController.swift
//  eCommerce
//
//  Created by Raven-Mac 2 on 7/11/21.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var confirmPass: UITextField!
    
    var handle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("SignUp view controller")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        handle = Auth.auth().addStateDidChangeListener { auth, user in
            
            if user == nil {
                
            } else {
                print(user)
                
                self.performSegue(withIdentifier: "goingToList", sender: nil)
                self.fullName.text = nil
                self.emailAddress.text = nil
                self.fullName.text = nil
                self.confirmPass.text = nil
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    @IBAction func doSighUp(_ sender: UIButton) {
        guard let email = emailAddress.text else { return }
        guard let pass = pass.text else { return }
        
        Auth.auth().createUser(withEmail: email, password: pass) { authResult, error in
//            guard let strongSelf = self else { return }
            
            if let error = error {
                let alert = UIAlertController(
                    title: "Sign Up Failed",
                    message: error.localizedDescription,
                    preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func gobackLoginView(_ sender: UIButton) {
//        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popToRootViewController(animated: true)
    }
}
