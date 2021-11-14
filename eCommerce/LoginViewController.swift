//
//  LoginViewController.swift
//  eCommerce
//
//  Created by Raven-Mac 2 on 30/10/21.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var handle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        registerForKeyboardNotifications()
        registerGesture()
        
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
        print("tap on sign up text")
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
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func registerGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        let leftGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft))
        leftGesture.direction = .left
        self.view.addGestureRecognizer(leftGesture)
        
        let sRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeRight))
        sRight.direction = .right
        view.addGestureRecognizer(sRight)
    }
    
    // Don't forget to unregister when done
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)
        
        print("deinit called")
    }
    
    @objc func keyboardWillShow(notification:NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        print("keyboardWillShow")
        
        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 25
        self.scrollView.contentInset = contentInset
    }
    
    @objc func keyboardWillHide(notification:NSNotification) {
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        self.scrollView.contentInset = contentInset
        print("keyboardWillHide")
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        emailAddress.resignFirstResponder()
        password.resignFirstResponder()
        print("dismissKeyboard")
    }
    
    @objc func swipeLeft() {
        print("swipeLeft")
    }
    
    @objc func swipeRight() {
        print("swipeRight")
        self.navigationController?.popViewController(animated: true)
        
    }
}

extension String {
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}
