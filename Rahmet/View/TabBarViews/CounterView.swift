//
//  CounterView.swift
//  Rahmet
//
//  Created by Elvina Shamoi on 21.02.2022.
//

import UIKit

class CounterView: UIView {

    var cnt = 0 {
        didSet {
            counterLabel.text = String(cnt)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var minusButton: UIButton = {
        let button = UIButton()
        button.setTitle("-", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(minusClicked), for: .touchUpInside)
        return button
    }()
    
    lazy var plusButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(plusClicked), for: .touchUpInside)
        return button
    }()
    
    lazy var counterLabel: UILabel = {
        let label = UILabel()
        label.text = String(cnt)
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    @objc func minusClicked() {
        if cnt > 1 {
            cnt -= 1
        }
        print(cnt)
        // else: delete from cart
    }
    
    @objc func plusClicked() {
        cnt += 1
    }

    
    func setupViews() {
        self.layer.cornerRadius = 10
        
        [minusButton, counterLabel, plusButton].forEach {
            self.addSubview($0)
        }
    }
    
    func setupConstraints() {
        minusButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(3)
        }
        
        counterLabel.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
        }
        
        plusButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(3)
        }
    }
}
