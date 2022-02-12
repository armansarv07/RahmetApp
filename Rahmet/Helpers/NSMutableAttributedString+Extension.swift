//
//  NSMutableAttributedString+Extension.swift
//  Rahmet
//
//  Created by Elvina Shamoi on 09.02.2022.
//
import UIKit

extension NSMutableAttributedString {
    public func setAsLink(textToFind:String, linkURL:String) -> Bool {
        let foundRange = self.mutableString.range(of: textToFind)
        if foundRange.location != NSNotFound {
            self.addAttribute(.link, value: linkURL, range: foundRange)
            return true
        }
        return false
    }
}
