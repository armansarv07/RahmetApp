//
//  OrderInput.swift
//  Rahmet
//
//  Created by Elvina Shamoi on 28.02.2022.
//

import Foundation

struct OrderInput: Codable {
    var restaurantID: Int?
    var products: [OrderCreateProduct]?
    
    enum CodingKeys: String, CodingKey {
        case restaurantID = "restaurant_id"
        case products
    }
}
