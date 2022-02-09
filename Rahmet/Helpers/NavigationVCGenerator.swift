//
//  NavigationVCGenerator.swift
//  Rahmet
//
//  Created by Arman on 09.02.2022.
//

import UIKit


class NavigationVCGenerator {
    static func generateNavigationController(rootViewController: UIViewController, image: UIImage, title: String, prefersLargeTitle: Bool = false) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.image = image
        navigationVC.tabBarItem.title = title
        navigationVC.navigationBar.prefersLargeTitles = prefersLargeTitle
        return navigationVC
    }
}
