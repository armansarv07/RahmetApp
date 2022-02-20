//
//  TemporaryOrderModel.swift
//  Rahmet
//
//  Created by Arman on 09.02.2022.
//

import Foundation


struct TemporaryOrder: Decodable, Hashable {
    let restaurantName: String?
    let totalPrice: Int?
    let orderStatus: String?
    let orderDate: String?
    let id: Int?
    var orderItems: [OrderItem]?
    
    func hash(into hasher: inout Hasher) {
      hasher.combine(id)
    }

    
    static func == (lhs: TemporaryOrder, rhs: TemporaryOrder) -> Bool {
      lhs.id == rhs.id
    }
}
