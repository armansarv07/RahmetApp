//
//  SegmentedCell.swift
//  Pods
//
//  Created by Arman on 16.02.2022.
//

import UIKit


class SegmentedCell: UICollectionViewCell, ConfigurableCell {
    static var reuseId: String = "SegmentCell"
    
    func configure<U>(with value: U) where U : Hashable {
        if isFirst {
            
        } else {
            
        }
    }
    
    
    let menuItem: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageResizer.resizeImage(image: #imageLiteral(resourceName: "menu"), width: 30, height: 30)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var isFirst: Bool = false {
        didSet {
            if isFirst {
                title.isHidden = true
            } else {
                title.isHidden = false
                menuItem.isHidden = true
            }
        }
    }
    
    let title: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.font = .systemFont(ofSize: 17)
        label.textColor = .gray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(title)
        self.addSubview(menuItem)
        setupConstraints()
    }
    
    func setupConstraints() {
        title.snp.makeConstraints { make in
            make.trailing.bottom.trailing.top.equalToSuperview()
        }
        menuItem.snp.makeConstraints { make in
            make.top.bottom.trailing.leading.equalToSuperview()
        }
        if isFirst {
            title.isHidden = true
        } else {
            title.isHidden = false
        }
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


import SwiftUI
struct SegmentsCellProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    struct ContainerView: UIViewControllerRepresentable {
        let menuVC = Menu(cafe: Cafe(name: "Mamma Mia", address: "ул. Бухар жырау, 66, уг. ул. Ауэзова", imgName: "cafeImage"))
        func makeUIViewController(context: Context) -> some UIViewController {
            return NavigationVCGenerator.generateNavigationController(rootViewController: menuVC, image: UIImage(), title: "Title", prefersLargeTitle: true)
        }
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }
    }
}
