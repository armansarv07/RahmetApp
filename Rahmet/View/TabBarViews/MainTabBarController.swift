//
//  MainTabBarController.swift
//  Rahmet
//
//  Created by Arman on 09.02.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tabBar.tintColor = .link
        self.tabBar.isTranslucent = true
        
        viewControllers = [
            NavigationVCGenerator.generateNavigationController(rootViewController: MainMenu(), image: ImageResizer.resizeImage(image: #imageLiteral(resourceName: "Vector"), width: 24, height: 24), title: "Главная", prefersLargeTitle: true),
            NavigationVCGenerator.generateNavigationController(rootViewController: MyOrders(), image: ImageResizer.resizeImage(image: #imageLiteral(resourceName: "Image"), width: 24, height: 24), title: "Мои заказы", prefersLargeTitle: true),
            NavigationVCGenerator.generateNavigationController(rootViewController: RahmetVC(), image: ImageResizer.resizeImage(image: #imageLiteral(resourceName: "rahmetLogo"), width: 24, height: 24).withRenderingMode(.alwaysOriginal), title: "Рахмет", prefersLargeTitle: true)
        ]
    }
}
