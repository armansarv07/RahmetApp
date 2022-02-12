//
//  UIStack+Extension.swift
//  Rahmet
//
//  Created by Arman on 10.02.2022.
//

import UIKit


extension UIStackView {
    convenience init(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
    }
}
