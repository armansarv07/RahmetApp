//
//  MainMenu.swift
//  Rahmet
//
//  Created by Arman on 09.02.2022.
//

import UIKit


class MainMenu: UIViewController {
    var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        setupNavigationBar()
    }
}


extension MainMenu: LayoutForNavigationVC {
    func setupConstraints() {
        
    }
    
    func setupNavigationBar() {
        navigationItem.title = "Мои заказы"
    }
    
    func setupCollectionView() {
        
    }
    
//    func createCompostionalLayout() -> UICollectionViewCompositionalLayout {
//
//    }
    
}



import SwiftUI

struct MainMenuProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        let menuVC = MainTabBarController()
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return menuVC
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}
