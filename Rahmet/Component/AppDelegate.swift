//
//  AppDelegate.swift
//  Rahmet
//
//  Created by Elvina Shamoi on 07.02.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window?.rootViewController = UINavigationController(rootViewController: Registration())
        self.window?.makeKeyAndVisible()
        return true
    }
}

