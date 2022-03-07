//
//  Products.swift
//  Rahmet
//
//  Created by Elvina Shamoi on 26.02.2022.
//

struct Product: Codable, Equatable {
    var id: Int?
    var name: String?
    var price: Int?
    var description: String?
    var image: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "product_id"
        case name = "product_name"
        case price
        case description
        case image
    }
}
