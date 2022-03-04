//
//  MenuData.swift
//  Rahmet
//
//  Created by Elvina Shamoi on 26.02.2022.
//

struct MenuData: Codable {
    var restaurantID: Int?
    var restaurantName: String?
    var location: String?
    var restaurantImages: [MenuRestaurantImage]?
    var productCategories: [ProductCategories]?
    
    enum CodingKeys: String, CodingKey {
        case restaurantID = "restaurant_id"
        case restaurantName = "restaurant_name"
        case location
        case restaurantImages = "restaurant_images"
        case productCategories = "product_categories"
    }
}
