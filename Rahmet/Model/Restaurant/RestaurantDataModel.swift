//
//  RestaurantDataModel.swift
//  Rahmet
//
//  Created by Elvina Shamoi on 28.02.2022.
//

struct RestaurantDataModel: Codable {
    var restaurantData: DetailedRestaurant?
    var image: RestaurantImage?
    
    enum CodingKeys: String, CodingKey {
        case restaurantData = "restaurant_data"
        case image
    }
}
