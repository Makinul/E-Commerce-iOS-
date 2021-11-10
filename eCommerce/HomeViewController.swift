//
//  HomeViewController.swift
//  eCommerce
//
//  Created by Raven-Mac 2 on 7/11/21.
//

import UIKit
import Firebase

class HomeViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    @IBAction func addItemAction(_ sender: Any) {
        print("addItemAction")
    }
    
    @IBAction func logout(_ sender: Any) {
        print("logout")

//        do {
//            try Auth.auth().signOut()
//        } catch let error {
//            print("sign out failed: \(error)")
//        }
        
        let alert = UIAlertController(
            title: "Logout alert!",
            message: "Want to logout?",
            preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { action in
            switch action.style{
                case .default:
                do {
                    try Auth.auth().signOut()
                    self.navigationController?.popToRootViewController(animated: true)
                } catch let error {
                    print("sign out failed: \(error)")
                }
                
                case .cancel:
                print("cancel")
                
                case .destructive:
                print("destructive")
                
            @unknown default:
                print("error")
            }
        }))
        
        alert.addAction(UIAlertAction(title: "NO", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
}
