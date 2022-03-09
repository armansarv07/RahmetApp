//
//  OrderRestaurant.swift
//  Rahmet
//
//  Created by Elvina Shamoi on 28.02.2022.
//

struct OrderRestaurant: Codable, Hashable {
    var id: Int?
    var name: String?
    var location: String?
    var createdAt: String?
    var updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, location
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
