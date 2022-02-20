//
//  PhotoModel.swift
//  Rahmet
//
//  Created by Arman on 17.02.2022.
//

import Foundation


struct PhotoModel: Hashable, Codable {
    let id: Int
    let photoName: String
    func hash(into hasher: inout Hasher) {
      hasher.combine(id)
    }

    
    static func == (lhs: PhotoModel, rhs: PhotoModel) -> Bool {
      lhs.id == rhs.id
    }
}
