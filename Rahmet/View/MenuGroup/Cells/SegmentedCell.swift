//
//  SegmentedCell.swift
//  Pods
//
//  Created by Arman on 16.02.2022.
//

import UIKit


class SegmentedCell: UICollectionViewCell {
    static var reuseId: String = "SegmentCell"
    
    var onCompletion: ((Int) -> Void)?
    
    var index: Int!
    
    let titleButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 7
        button.clipsToBounds = true
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.minimumScaleFactor = 0.4
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        return button
    }()
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? .gray.withAlphaComponent(0.2) : .clear
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(titleButton)
        self.layer.cornerRadius = 7
        self.clipsToBounds = true
        titleButton.backgroundColor = .clear
        titleButton.addTarget(self, action: #selector(callCompletion), for: .touchUpInside)
        setupConstraints()
    }
    
    func setupConstraints() {
        titleButton.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    @objc private func callCompletion() {
        onCompletion?(index)
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
