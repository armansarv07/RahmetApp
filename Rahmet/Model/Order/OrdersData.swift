//
//  OrdersData.swift
//  Rahmet
//
//  Created by Elvina Shamoi on 28.02.2022.
//

struct DataOfOrder: Codable {
    var order: [OrdersData]?
}

struct OrdersData: Codable, Hashable {
    var orderID: Int?
    var total: Int?
    var userID: Int?
    var id: Int?
    var restaurantID: Int?
    var restaurant: OrderRestaurant?
    var orderDetail: [OrderDetail]?
    var orderStatus: Int?
    var createdAt: String?
    var updatedAt: String?
    var user: User?
    
    enum CodingKeys: String, CodingKey {
        case orderID = "order_id"
        case userID = "user_id"
        case restaurant
        case total, id, user
        case restaurantID = "restaurant_id"
        case orderDetail = "order_detail"
        case orderStatus = "order_status"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
