//
//  Segment.swift
//  Rahmet
//
//  Created by Arman on 20.02.2022.
//

import Foundation


struct Segment: Hashable, Identifiable {
    let id: Int
    let title: String
    
    func hash(into hasher: inout Hasher) {
      hasher.combine(id)
    }

    
    static func == (lhs: Segment, rhs: Segment) -> Bool {
      lhs.id == rhs.id
    }
}
