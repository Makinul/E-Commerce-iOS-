//
//  GroupViewController.swift
//  eCommerce
//
//  Created by Raven-Mac 2 on 15/11/21.
//

import UIKit
import FirebaseDatabase

class GroupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        productArray.removeAll()
        readGroupData()
    }
    
    private var productArray: Array<Product> = []
    
    private func readGroupData() {
        let ref: DatabaseReference = Database.database().reference()
        
        ref.child("products/categories").getData(completion:  { error, snapshot in
            guard error == nil else {
                print(error!.localizedDescription)
                return;
            }
            
            
            
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot {
                    if childSnapshot.key == "version" {
                        continue
                    }
                    let dictionary = childSnapshot.value as? [String:Any]
                    let product = Product(dictionary: dictionary!)
                    
                    print(product)
                }
            }
//            let name = snapshot.value as? String ?? "Unknown";
//            print(name)
        });
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}
