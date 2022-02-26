//
//  DetailedRestaurant.swift
//  Rahmet
//
//  Created by Elvina Shamoi on 26.02.2022.
//

struct DetailedRestaurant: Codable {
    var id: Int?
    var name: String?
    var location: String?
    var createdAt: String?
    var updatedAt: String?
    var images: [RestaurantImage]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name, location
        case createdAt = "created_at"
        case updatedAt = "updates_at"
        case images = "restaurant_images"
    }
}
