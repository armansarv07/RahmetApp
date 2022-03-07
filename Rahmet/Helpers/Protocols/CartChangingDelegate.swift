//
//  CartChanging.swift
//  Rahmet
//
//  Created by Elvina Shamoi on 07.03.2022.
//

import Foundation

protocol CartChangingDelegate {
    func changeQuantity(product: Product, quantity: Int)
}
