//
//  FakeCategories.swift
//  Rahmet
//
//  Created by Elvina Shamoi on 14.02.2022.
//

import UIKit

class FakeCategories {
    static let shared = FakeCategories()
    
    let fakeCategoriesData: [CategoryFake] = [
        CategoryFake(id: 0, name: "Пицца", dishes: [
            Dish(id: 0, name: "Пицца Маргарита", price: 1600, image: "pizzaimg1", description: "Любая маленькая пицца на выбор, порция фри и Coca Cola")
        ]),
        CategoryFake(id: 1, name: "Бургеры", dishes: []),
        CategoryFake(id: 2, name: "Паста", dishes: []),
        CategoryFake(id: 3, name: "Салаты", dishes: []),
        CategoryFake(id: 4, name: "Супы", dishes: []),
        CategoryFake(id: 5, name: "Напитки", dishes: []),
        CategoryFake(id: 6, name: "Десерты", dishes: []),
        CategoryFake(id: 7, name: "Веган", dishes: []),
        CategoryFake(id: 8, name: "Алкоголь", dishes: [])
    ]
}
