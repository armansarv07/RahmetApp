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
    var restaurantImage: MenuRestaurantImage?
    var productCategories: [ProductCategories]?
    
    enum CodingKeys: String, CodingKey {
        case restaurantID = "restaurant_id"
        case restaurantName = "restaurant_name"
        case location
        case restaurantImage = "restaurant_images"
        case productCategories = "product_categories"
    }
}
