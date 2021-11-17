//
//  DetailsViewController2.swift
//  eCommerce
//
//  Created by Raven-Mac 2 on 17/11/21.
//

import UIKit

class DetailsViewController2: UIViewController {

    var selectedProduct: Product!
    
    @IBOutlet weak var detailsImageView: UIImageView!
    @IBOutlet weak var detailsTitle: UILabel!
    @IBOutlet weak var detailsDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("DetailsViewController2")
        // Do any additional setup after loading the view.
        
        print(selectedProduct.name ?? "Test False")
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        let backButton = UIBarButtonItem()
        backButton.title = "My Back"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        self.navigationController?.navigationBar.topItem?.title = "Details"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.set
        
        detailsImageView.image = UIImage(named: "halloween")
        detailsTitle.text = selectedProduct.name
        detailsDescription.text = selectedProduct.icon
    }
}
