//
//  RestaurantImage.swift
//  Rahmet
//
//  Created by Elvina Shamoi on 26.02.2022.
//

struct RestaurantImage: Codable {
    var id: Int?
    var imageURL: String?
    var restaurantID: Int?
    var createdAt: String?
    var updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case imageURL = "image_url"
        case restaurantID = "restaurant_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
