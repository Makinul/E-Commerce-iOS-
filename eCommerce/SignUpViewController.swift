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
                
                self.performSegue(withIdentifier: Constants.segueToGoHome, sender: nil)
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
        self.navigationController?.popViewController(animated: true)
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
    }

//    // Don't forget to unregister when done
//    deinit {
//        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardDidShow, object: nil)
//        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardDidHide, object: nil)
//    }
    
    @objc func keyboardWillShow(notification:NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)

//        var contentInset:UIEdgeInsets = self.scrollView.contentInset
//        contentInset.bottom = keyboardFrame.size.height + 20
//        self.scrollView.contentInset = contentInset
    }

    @objc func keyboardWillHide(notification:NSNotification) {
//        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
//        self.scrollView.contentInset = contentInset
    }
}
