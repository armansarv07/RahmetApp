//
//  OrderProduct.swift
//  Rahmet
//
//  Created by Elvina Shamoi on 28.02.2022.
//

struct OrderProduct: Codable {
    var id: Int?
    var categoryID: Int?
    var name: String?
    var price: Int?
    var description: String?
    var image: String?
    var createdAt: String?
    var updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case categoryID = "product_category_id"
        case name, price, description, image
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
