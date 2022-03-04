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
    static var baseURL = "https://intern.rahmetapp.kz/api"
    static var tokenKey = "accessToken"
    static let accessToken: String? = KeychainWrapper.standard.string(forKey: Constants.tokenKey)
}

