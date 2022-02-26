//
//  PhotosDatabase.swift
//  Rahmet
//
//  Created by Arman on 12.02.2022.
//

import UIKit

struct MenuModel: Decodable, Hashable {
    let photosName: [String] = [
        "rest1",
        "rest2",
        "rest3",
        "rest4",
        "rest5"
    ]
    
    let categories: [String] = [
        "Пицца", "Напитки", "Салаты", "Супы"
    ]
    
    let id: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    
    static func == (lhs: MenuModel, rhs: MenuModel) -> Bool {
      lhs.id == rhs.id
    }
}
