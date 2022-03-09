//
//  OrderPositionsCell.swift
//  Rahmet
//
//  Created by Elvina Shamoi on 18.02.2022.
//

import UIKit

class OrderPositionsCell: UITableViewCell {

    var item: OrderDetail? {
        didSet {
            if let num = item?.quantity, let name = item?.productID, let price = item?.productID {
                leftLabel.text = "\(num) x \(name)"
                rightLabel.text = "\(num * price) тг"
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
    
    let leftLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = true
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    let rightLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = true
        label.font = .systemFont(ofSize: 14)
        return label
    }()
}

extension OrderPositionsCell {
    static var reuseId: String = "PositionsCell"
    
    func setupViews() {
        [leftLabel, rightLabel].forEach {
            self.addSubview($0)
        }
    }
    
    func setupConstraints() {
        leftLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.top.bottom.equalToSuperview()
        }
        rightLabel.snp.makeConstraints { make in
            make.left.equalTo(Constants.screenWidth * 0.75)
            make.right.equalToSuperview().offset(15)
            make.top.bottom.equalToSuperview()
        }
    }
}
