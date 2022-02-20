//
//  FakeCategories.swift
//  Rahmet
//
//  Created by Elvina Shamoi on 14.02.2022.
//

import UIKit

class FakeCategories {
    static let shared = FakeCategories()
    
    let fakeCategoriesData: [Category] = [
        Category(id: 0, name: "Пицца", dishes: [
            Dish(id: 0, name: "Пицца Маргарита", price: 1600, image: "pizzaimg1", description: "Любая маленькая пицца на выбор, порция фри и Coca Cola")
        ]),
        Category(id: 1, name: "Бургеры", dishes: []),
        Category(id: 2, name: "Паста", dishes: []),
        Category(id: 3, name: "Салаты", dishes: []),
        Category(id: 4, name: "Супы", dishes: []),
        Category(id: 5, name: "Напитки", dishes: []),
        Category(id: 6, name: "Десерты", dishes: []),
        Category(id: 7, name: "Веган", dishes: []),
        Category(id: 8, name: "Алкоголь", dishes: [])
    ]
}
