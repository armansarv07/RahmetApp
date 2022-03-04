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
            switch cnt {
            case 0:
                remakeViews()
                remakeContraints()
            case 1...:
                setupViews()
                setupConstraints()
            default:
                break
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        [minusButton, counterLabel, plusButton].forEach {
            self.addSubview($0)
        }
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
        if cnt >= 1 {
            cnt -= 1
        }
        
        print(cnt)
        // else: delete from cart
    }
    
    func remakeViews() {
        if minusButton.isHidden == false && counterLabel.isHidden == false {
            minusButton.isHidden = true
            counterLabel.isHidden = true
        } else {
            plusButton.isHidden = false
        }
    }
    
    func remakeContraints() {
        plusButton.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
        }
//        self.snp.makeConstraints { make in
//            make.width.equalTo(25)
//        }
    }
    
    @objc func plusClicked() {
        cnt += 1
    }

    
    func setupViews() {
        if plusButton.isHidden == false {
            plusButton.snp.remakeConstraints { make in
                make.centerY.equalToSuperview()
                make.right.equalToSuperview().inset(3)
            }
        }
        if minusButton.isHidden && counterLabel.isHidden {
            minusButton.isHidden = false
            counterLabel.isHidden = false
        }
        self.layer.cornerRadius = 10
//        [minusButton, counterLabel, plusButton].forEach {
//            self.addSubview($0)
//        }
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
