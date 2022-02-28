//
//  OrderDetail.swift
//  Rahmet
//
//  Created by Elvina Shamoi on 28.02.2022.
//

struct OrderDetail: Codable {
    var id: Int?
    var quantity: Int?
    var product: [OrderProduct]?
}
