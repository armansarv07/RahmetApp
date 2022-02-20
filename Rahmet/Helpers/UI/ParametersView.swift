//
//  ParametersView.swift
//  Rahmet
//
//  Created by Elvina Shamoi on 18.02.2022.
//

import UIKit
import SnapKit

class ParametersView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var mainLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .gray
        return label
    }()
    
    lazy var subLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    
    func setupViews() {
        let stackView = UIStackView(arrangedSubviews: [mainLabel, subLabel], axis: .vertical, spacing: 10)
        self.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.top.bottom.equalToSuperview()
        }
    }
}
