//
//  CategoryTableViewCell.swift
//  Rahmet
//
//  Created by Arman on 08.03.2022.
//

import UIKit


class CategoryTableViewCell: UITableViewCell {
    static let reuseId: String = "CategoryTableViewCell"
    
    var category: ProductCategories? {
        didSet {
            if let title = category?.name { categoryLabel.text = title }
            if let productsNumber = category?.products?.count { productsNumberLabel.text = "\(productsNumber)" }
        }
    }
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    
    let productsNumberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textColor = .gray
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    func setupConstraints() {
        self.addSubview(categoryLabel)
        self.addSubview(productsNumberLabel)
        
        categoryLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        
        productsNumberLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

