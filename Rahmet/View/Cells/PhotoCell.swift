//
//  PhotoCell.swift
//  Rahmet
//
//  Created by Arman on 15.02.2022.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    static var reuseId: String = "PhotoCell"
    
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    let paginationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textColor = .black
        label.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.8)
        label.layer.cornerRadius = 4
        label.clipsToBounds = true
        label.textAlignment = .center
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    func setupConstraints() {
        contentView.addSubview(imageView); imageView.snp.makeConstraints { $0.trailing.leading.bottom.top.equalToSuperview() }
        imageView.addSubview(paginationLabel)
        paginationLabel.snp.makeConstraints { make in
            make.bottom.leading.equalToSuperview().inset(16)
            make.width.equalTo(30)
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



//import SwiftUI
//struct PhotoCellProvider: PreviewProvider {
//    static var previews: some View {
//        ContainerView().edgesIgnoringSafeArea(.all)
//    }
//    struct ContainerView: UIViewControllerRepresentable {
//        let menuVC = Menu(cafe: Cafe(name: "Mamma Mia", address: "ул. Бухар жырау, 66, уг. ул. Ауэзова", imgName: "cafeImage"))
//        func makeUIViewController(context: Context) -> some UIViewController {
//            return NavigationVCGenerator.generateNavigationController(rootViewController: menuVC, image: UIImage(), title: "Title", prefersLargeTitle: true)
//        }
//        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
//        }
//    }
//}
