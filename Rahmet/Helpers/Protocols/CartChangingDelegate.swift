//
//  CartChanging.swift
//  Rahmet
//
//  Created by Elvina Shamoi on 07.03.2022.
//

protocol CartChangingDelegate {
    func changeQuantity(product: Product, quantity: Int)
    func reloadCart(cart: [CartItem]?)
}
