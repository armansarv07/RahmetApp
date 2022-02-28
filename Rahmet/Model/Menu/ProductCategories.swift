//
//  ProductCategories.swift
//  Rahmet
//
//  Created by Elvina Shamoi on 26.02.2022.
//

struct ProductCategories: Codable {
    var id: Int?
    var name: String?
    var products: [Product]?
    
    enum CodingKeys: String, CodingKey {
        case id = "product_category_id"
        case name = "product_category_name"
        case products
    }
}
