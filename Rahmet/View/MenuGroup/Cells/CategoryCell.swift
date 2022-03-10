//
//  CategoryCell.swift
//  Rahmet
//
//  Created by Elvina Shamoi on 14.02.2022.
//

import SnapKit
import UIKit

class CategoryCell: UICollectionViewCell {
    
    // MARK: - Public properties -
    static let reuseIdentifier = "CategoryCell"
    
    var category: Category? {
        didSet {
            categoryNameLabel.text = category?.name
        }
    }
    
    override var isSelected: Bool {
        didSet {
            categoryNameLabel.textColor = isSelected ? .darkGray : .lightGray
            selectBarIndicator.backgroundColor = isSelected ? .secondarySystemBackground : .systemBackground
            selectBarIndicator.isHidden = !isSelected
        }
    }
    
    
    // MARK: - Private properties -

    private lazy var categoryNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Category name"
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var selectBarIndicator: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 15
        view.isHidden = true
        return view
    }()
    
    // MARK: - Lifecycle -

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with category: Category) {
        self.category = category
    }
}

extension CategoryCell {
    func setupUI() {
        contentView.addSubview(selectBarIndicator)
        selectBarIndicator.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.bottom.equalTo(self)
            make.height.equalTo(self)
        }
        contentView.addSubview(categoryNameLabel)
        categoryNameLabel.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(self)
        }
    }
}
