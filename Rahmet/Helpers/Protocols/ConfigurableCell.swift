//
//  ConfigurableCell.swift
//  Rahmet
//
//  Created by Arman on 09.02.2022.
//

import Foundation


protocol ConfigurableCell {
    static var reuseId: String { get }
    func configure<U: Hashable>(with value: U)
}
