//
//  HomeTableViewCell.swift
//  eCommerce
//
//  Created by Raven-Mac 2 on 16/11/21.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        
        if let text = self.name.text {
            print(text)
        }
    }
}
