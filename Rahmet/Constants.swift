//
//  Constants.swift
//  Rahmet
//
//  Created by Elvina Shamoi on 09.02.2022.
//
import UIKit
import SwiftKeychainWrapper

class Constants {
    static var screenHeight = UIScreen.main.bounds.height
    static var screenWidth = UIScreen.main.bounds.width
    static var baseURL = "http://142.93.107.238/api"
    static var tokenKey = "accessToken"
    static let accessToken: String? = KeychainWrapper.standard.string(forKey: Constants.tokenKey)
}

