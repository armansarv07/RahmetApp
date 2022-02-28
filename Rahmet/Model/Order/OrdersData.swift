//
//  OrdersData.swift
//  Rahmet
//
//  Created by Elvina Shamoi on 28.02.2022.
//

struct OrdersData: Codable {
    var orderID: Int?
    var total: Int?
    var userID: Int?
    var restaurant: OrderRestaurant?
    var orderDetail: [OrderDetail]?
    
    enum CodingKeys: String, CodingKey {
        case orderID = "order_id"
        case userID = "user_id"
        case restaurant
        case orderDetail = "order_detail"
    }
}
