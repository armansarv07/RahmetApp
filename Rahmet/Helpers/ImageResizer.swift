//
//  Image+Extension.swift
//  Rahmet
//
//  Created by Arman on 09.02.2022.
//

import Foundation
import UIKit

class ImageResizer {
    static func resizeImage(image: UIImage, width: CGFloat, height: CGFloat) -> UIImage {
        let newImage = image
        let size = CGSize(width: width, height: height)
        return newImage.scalePreservingAspectRatio(targetSize: size)
    }
}
