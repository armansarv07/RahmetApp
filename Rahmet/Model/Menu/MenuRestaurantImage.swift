//
//  MenuRestaurantImage.swift
//  Rahmet
//
//  Created by Elvina Shamoi on 26.02.2022.
//

struct MenuRestaurantImage: Codable {
    var imageID: Int?
    var url: String?
    
    enum CodingKeys: String, CodingKey {
        case imageID = "image_id"
        case url
    }
}
