//
//  OrderCell.swift
//  Rahmet
//
//  Created by Arman on 09.02.2022.
//

import UIKit
import SnapKit

class OrderCell: UICollectionViewCell, ConfigurableCell {
    static var reuseId: String = "OrderCell"
    
    let restaurantTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    let orderDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .gray
        return label
    }()
    
    let orderAmountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .gray
        return label
    }()
    
    let orderStatusLabel = UILabel()
    
    let arrowImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "arrow")
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        layer.cornerRadius = 10
        self.clipsToBounds = true
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure<U>(with value: U) where U : Hashable {
        guard let order: TemporaryOrder = value as? TemporaryOrder else { return }
        restaurantTitleLabel.text = order.restaurantName
        orderDateLabel.text = order.orderDate
        orderAmountLabel.text = "\(order.totalPrice) тг"
        statusCreator(status: order.orderStatus)
    }
}


extension OrderCell {
    func setupConstraints() {
        self.addSubview(arrowImage)
        arrowImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(16)
        }
        let titleStackView = UIStackView(arrangedSubviews: [restaurantTitleLabel], axis: .horizontal, spacing: 50)
        titleStackView.alignment = .fill
        self.addSubview(orderDateLabel)
        orderDateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.trailing.equalTo(arrowImage).inset(25)
        }
        
        let globalStackView = UIStackView(arrangedSubviews: [titleStackView, orderAmountLabel, orderStatusLabel], axis: .vertical, spacing: 8)
        
        self.addSubview(globalStackView)
        
        globalStackView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(16)
        }
    }
    
    func statusCreator(status: String) {
        let attributeColor: UIColor
        let statusAttribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular),
                               NSAttributedString.Key.foregroundColor: UIColor.gray]
        let statusAttribtedString = NSMutableAttributedString(string: "Статус - ", attributes: statusAttribute)
        let localizedString: String
        switch status {
        case "processing":
            attributeColor = #colorLiteral(red: 0.1019881442, green: 0.676645577, blue: 1, alpha: 1)
            localizedString = "В обработке"
        case "in the kitchen":
            attributeColor = #colorLiteral(red: 0.9535714984, green: 0.4975312948, blue: 0.148396194, alpha: 1)
            localizedString = "На кухне"
        case "ready":
            attributeColor = #colorLiteral(red: 0.1394651532, green: 0.6525734067, blue: 0.2758979797, alpha: 1)
            localizedString = "Готов"
        case "completed":
            attributeColor = UIColor.gray
            localizedString = "Завершен"
        default:
            attributeColor = UIColor.gray
            localizedString = "Error"
        }
        let orderAttribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular),
                               NSAttributedString.Key.foregroundColor: attributeColor]
        let orderAttribtedString = NSMutableAttributedString(string: localizedString, attributes: orderAttribute)
        statusAttribtedString.append(orderAttribtedString)
        orderStatusLabel.attributedText = statusAttribtedString
    }
}


import SwiftUI

struct CellProvider: PreviewProvider {
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
