//
//  MenuCell.swift
//  Rahmet
//
//  Created by Elvina Shamoi on 14.02.2022.
//

import UIKit

class MenuCell: UITableViewCell {

    var category: CategoryFake? {
        didSet {
            guard let category = category else {return}
            if let name = category.name {
                nameLabel.text = name
            }
            if let num = category.dishes?.count {
                dishesCountLabel.text = String(num)
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
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    let dishesCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.clipsToBounds = true
        label.numberOfLines = 0
        return label
    }()
    
    func setupViews() {
        [nameLabel, dishesCountLabel].forEach { contentView.addSubview($0) }
    }
    
    func setupConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20)
        }
        
        dishesCountLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(Constants.screenWidth / 1.1)
            make.right.equalToSuperview().offset(20)
        }
    }
}
