//
//  MyOrders.swift
//  Rahmet
//
//  Created by Arman on 09.02.2022.
//

import UIKit

class MyOrders: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        setupNavigationBar()
    }
}


extension MyOrders: LayoutForNavigationVC {
    func setupConstraints() {
        
    }
    
    func setupNavigationBar() {
        navigationItem.title = "Мои заказы"
    }
    
    
}




import SwiftUI

struct MyOrdersProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        let ordersVC = MainTabBarController()
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return ordersVC
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}
