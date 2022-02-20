//
//  FakePhotosDatabase.swift
//  Rahmet
//
//  Created by Arman on 15.02.2022.
//

import Foundation


class FakeMenuDatabase {
    static let shared = FakeMenuDatabase()
    let menus: [MenuModel] = [
        MenuModel(id: 1)
    ]
    private init() {}
}
