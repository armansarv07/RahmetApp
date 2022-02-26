//
//  RestaurantData.swift
//  Rahmet
//
//  Created by Elvina Shamoi on 26.02.2022.
//

struct RestaurantData: Codable {
    var restaurantData: DetailedRestaurant?
    
    enum CodingKeys: String, CodingKey {
        case restaurantData = "restaurant_data"
    }
}
