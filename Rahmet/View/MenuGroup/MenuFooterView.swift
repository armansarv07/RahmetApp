//
//  MenuFooter.swift
//  Rahmet
//
//  Created by Arman on 01.03.2022.
//

import UIKit

class MenuFooter: UIView {
    let blueButton = BlueButton(text: "Корзина", rightText: "1 600 ₸", leftText: "1 шт.", isActive: true)
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(blueButton)
        blueButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(15)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//import SwiftUI
//struct MenuFooterVCProvider: PreviewProvider {
//    static var previews: some View {
//        ContainerView().edgesIgnoringSafeArea(.all)
//    }
//    struct ContainerView: UIViewControllerRepresentable {
//        let menuVC = MenuViewController(restaurant: Restaurant(restaurant: RestaurantDataModel(restaurantData: DetailedRestaurant(id: 1, name: "Mamma Mia", location: "Baker Street 221B", createdAt: "20.02.2022", updatedAt: "20.02.2022", images: []), image: nil)))
//        func makeUIViewController(context: Context) -> some UIViewController {
//            return NavigationVCGenerator.generateNavigationController(rootViewController: menuVC, image: UIImage(), title: "Title", prefersLargeTitle: true)
//        }
//        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
//        }
//    }
//}
