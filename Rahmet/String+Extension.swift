//
//  String+Extension.swift
//  Rahmet
//
//  Created by Elvina Shamoi on 12.02.2022.
//
import UIKit

extension String {
    var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
}
