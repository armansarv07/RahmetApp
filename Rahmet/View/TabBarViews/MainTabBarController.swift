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
            NavigationVCGenerator.generateNavigationController(rootViewController: MainMenu(), image: ImageResizer.resizeImage(image: #imageLiteral(resourceName: "Vector"), width: 22, height: 22), title: "Главная", prefersLargeTitle: true),
            NavigationVCGenerator.generateNavigationController(rootViewController: MyOrders(), image: ImageResizer.resizeImage(image: #imageLiteral(resourceName: "Image"), width: 22, height: 22), title: "Мои заказы", prefersLargeTitle: true),
            NavigationVCGenerator.generateNavigationController(rootViewController: RahmetVC(), image: ImageResizer.resizeImage(image: #imageLiteral(resourceName: "rahmetLogo"), width: 22, height: 22).withRenderingMode(.alwaysOriginal), title: "Рахмет", prefersLargeTitle: true)
        ]
    }
}
