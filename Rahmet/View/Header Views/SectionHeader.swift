//
//  SectionHeader.swift
//  Rahmet
//
//  Created by Arman on 17.02.2022.
//

import UIKit
import SnapKit

class SectionHeader: UICollectionReusableView {
    static let reuseId = "SectionHeader"
    let title = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(title)
        
        title.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
        }
    }
    
    func configure(text: String, font: UIFont?, textColor: UIColor) {
        title.textColor = textColor
        title.font = font
        title.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
