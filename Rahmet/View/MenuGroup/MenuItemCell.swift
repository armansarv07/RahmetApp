//
//  MenuItemCell.swift
//  Rahmet
//
//  Created by Arman on 04.03.2022.
//

import UIKit

class MenuItemCell: UITableViewCell {
    
    static let reuseId: String = "MenuItemCell"
    
    var product: Product? {
        didSet {
            guard let product = product else {return}
            if let name = product.name{
                nameLabel.text = name
            }
            if let desc = product.description {
                descriptionLabel.text = desc
            }
            if let imageName = product.image {
                productImageView.image = UIImage.init(named: imageName)
            }
            if let price = product.price {
                priceLabel.text = "\(price) тг"
            }
            counterView.cnt = num
        }
    }
    
    var num: Int = 0
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.isUserInteractionEnabled = true
        setupViews()
        setupConstraints()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    let productImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.layer.cornerRadius = 10
        img.clipsToBounds = true
        return img
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.clipsToBounds = true
        label.numberOfLines = 0
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemBlue
        label.clipsToBounds = true
        label.numberOfLines = 0
        return label
    }()
    
    let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 5
        return view
    }()
    
    lazy var counterView = CounterView()
    
    func setupViews() {
        counterView.layer.backgroundColor = UIColor.secondarySystemBackground.cgColor
        [nameLabel, descriptionLabel, priceLabel].forEach { stackView.addArrangedSubview($0)}
        [productImageView, stackView, counterView].forEach { contentView.addSubview($0) }
    }
    
    func setupConstraints() {
        productImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(15)
            make.width.equalTo(90)
            make.height.equalTo(90)
        }
        
        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(productImageView.snp.left).offset(-15)
            make.left.equalToSuperview().offset(20)
        }
        
        counterView.snp.makeConstraints { make in
            make.width.equalTo(productImageView.width)
            make.left.equalTo(productImageView)
//            make.left.right.equalTo(productImageView)
            make.bottom.equalToSuperview().inset(5)
            make.height.equalTo(30)
        }
    }
}




import SwiftUI
struct MenuViewCellProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    struct ContainerView: UIViewControllerRepresentable {
        let menuVC = MenuViewController(restaurant: Restaurant(restaurant: RestaurantDataModel(restaurantData: DetailedRestaurant(id: 1, name: "Mamma Mia", location: "Baker Street 221B", createdAt: "20.02.2022", updatedAt: "20.02.2022", images: []), image: nil)))
        func makeUIViewController(context: Context) -> some UIViewController {
            return NavigationVCGenerator.generateNavigationController(rootViewController: menuVC, image: UIImage(), title: "Title", prefersLargeTitle: true)
        }
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }
    }
}
