//
//  OrderDetail.swift
//  Rahmet
//
//  Created by Elvina Shamoi on 28.02.2022.
//

struct OrderDetail: Codable, Hashable {
    var id: Int?
    var orderID: Int?
    var quantity: Int?
    var productID: Int?
    var createdAt: String?
    var updatedAt: String?
//    var product: [OrderProduct]?
    
    enum CodingKeys: String, CodingKey {
        case id, quantity
//        case product
        case orderID = "order_id"
        case productID = "product_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
