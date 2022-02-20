//
//  OrderItem.swift
//  Rahmet
//
//  Created by Elvina Shamoi on 15.02.2022.
//

import UIKit

struct OrderItem: Decodable, Hashable {
    var itemName: String?
    var numberOfItems: Int?
    var itemPrice: Double?
    var imgName: String?
}
