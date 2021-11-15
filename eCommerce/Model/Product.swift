//
//  Product.swift
//  eCommerce
//
//  Created by Raven-Mac 2 on 15/11/21.
//

import Foundation

public class Product: Codable {
    var id: String?
    var name: String?
    var url: String?
    var icon: String?
    var order: Int
    var hasSubCategory: Bool
    
    init(dictionary: [String: Any]) {
        self.id = dictionary["id"] as? String
        self.name = dictionary["name"] as? String
        self.url = dictionary["url"] as? String
        self.icon = dictionary["icon"] as? String
        self.order = dictionary["order"] as? Int ?? 0
        self.hasSubCategory = dictionary["hasSubCategory"] as? Bool ?? false
    }
}
