//
//  SegmentedCell.swift
//  Pods
//
//  Created by Arman on 16.02.2022.
//

import UIKit


class SegmentedCell: UICollectionViewCell, ConfigurableCell {
    static var reuseId: String = "SegmentCell"
    
    var onCompletion: ((Int) -> Void)?
    
    var index: Int!
    
    func configure<U>(with value: U) where U : Hashable {
        
    }
    
    let titleButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 17)
        button.layer.cornerRadius = 7
        button.clipsToBounds = true
        button.setTitleColor(.gray, for: .normal)
        return button
    }()
    
    override var isSelected: Bool {
        didSet {
            titleButton.backgroundColor = isSelected ? .gray.withAlphaComponent(0.2) : .clear
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(titleButton)
        self.layer.cornerRadius = 7
        self.clipsToBounds = true
        titleButton.addTarget(self, action: #selector(callCompletion), for: .touchUpInside)
        setupConstraints()
    }
    
    func setupConstraints() {
        titleButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(8)
            make.top.bottom.equalToSuperview()
        }
    }
    
    @objc private func callCompletion() {
        onCompletion?(index)
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
