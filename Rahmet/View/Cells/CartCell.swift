//
//  CartCell.swift
//  Rahmet
//
//  Created by Elvina Shamoi on 18.02.2022.
//

import UIKit

class CartCell: UITableViewCell {

    var item: OrderItem? {
        didSet {
            if let num = item?.numberOfItems, let name = item?.itemName, let price = item?.itemPrice, let img = item?.imgName {
                nameLabel.text = name
                priceLabel.text = "\(price) тг"
                itemImageView.image = UIImage.init(named: img)
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    let nameLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = true
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    let priceLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = true
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()
    
    let itemImageView: UIImageView = {
        var img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.layer.cornerRadius = 8
        return img
    }()
}

extension CartCell {
    static var reuseId: String = "CartCell"
    
    func setupViews() {
        [nameLabel, priceLabel, itemImageView].forEach {
            self.addSubview($0)
        }
    }
    
    func setupConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalTo(Constants.screenWidth * 0.7)
            make.top.equalToSuperview().offset(8)
        }
        priceLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalTo(Constants.screenWidth * 0.7)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview()
        }
        itemImageView.snp.makeConstraints { make in
            make.left.equalTo(Constants.screenWidth * 0.75)
            make.right.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
            make.height.equalTo(80)
        }
    }
}
