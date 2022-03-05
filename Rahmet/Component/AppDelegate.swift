//
//  AppDelegate.swift
//  Rahmet
//
//  Created by Elvina Shamoi on 07.02.2022.
//

import UIKit
import SwiftKeychainWrapper

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window?.rootViewController = UINavigationController(rootViewController: MainTabBarController())
        let accessToken: String? = KeychainWrapper.standard.string(forKey: Constants.tokenKey)
        if accessToken != nil {
            // if user already logged in -> we should open main tabbar page
            self.window?.rootViewController = UINavigationController(rootViewController: MainTabBarController())
        }
        self.window?.makeKeyAndVisible()
        self.window?.tintColor = .black
        return true
    }
}

