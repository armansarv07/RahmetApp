//
//  PhotosDatabase.swift
//  Rahmet
//
//  Created by Arman on 12.02.2022.
//

import UIKit
import SwiftUI

class FakePhotosDatabase {
    static let shared = FakePhotosDatabase()
    let database: [UIImage] = [#imageLiteral(resourceName: "rest1"), #imageLiteral(resourceName: "rest2"), #imageLiteral(resourceName: "rest4"), #imageLiteral(resourceName: "cafeImage"), #imageLiteral(resourceName: "rest3")]
    private init() {}
}
