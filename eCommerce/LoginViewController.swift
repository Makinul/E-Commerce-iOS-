//
//  LoginViewController.swift
//  eCommerce
//
//  Created by Raven-Mac 2 on 30/10/21.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var handle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("Main view controller")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        self.tabBarController?.navigationItem.hidesBackButton = true
        self.navigationItem.hidesBackButton = true
//        self.navigationItem.setHidesBackButton(true, animated: true)
        
        handle = Auth.auth().addStateDidChangeListener { auth, user in
            
            if user == nil {
                
            } else {
                self.performSegue(withIdentifier: Constants.segueToGoHome, sender: nil)
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

        if !email.isValidEmail() {
            showSimpleAlert(message: "Please insert valid email address")
            return
        }
        
        if pass.count < 6 {
            showSimpleAlert(message: "Please insert at least 6 digit password")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: pass) { [weak self] authResult, error in
            guard let strongSelf = self else { return }

            if let error = error {
                let alert = UIAlertController(
                    title: "Login Failed",
                    message: error.localizedDescription,
                    preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: "OK", style: .default))
                strongSelf.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func signUp(_ sender: Any) {
        self.performSegue(withIdentifier: Constants.segueToGoSignUp, sender: nil)
    }
    
    private func showSimpleAlert(title: String = "Alert!", message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
}

extension String {
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}
