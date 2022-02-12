//
//  CafeCell.swift
//  Rahmet
//
//  Created by Elvina Shamoi on 10.02.2022.
//
import UIKit

class CafeCell: UITableViewCell {

    var cafe: Cafe? {
        didSet {
            guard let cafeItem = cafe else {return}
            if let name = cafeItem.name {
                nameLabel.text = name
            }
            if let address = cafeItem.address {
                addressLabel.text = address
            }
            if let cafeImgName = cafeItem.imgName {
                cafeImageView.image = UIImage(named: cafeImgName)
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
    
    let cafeImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.layer.cornerRadius = 10
        img.clipsToBounds = true
        return img
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.clipsToBounds = true
        label.numberOfLines = 0
        return label
    }()
    
    let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 5
        return view
    }()
    
    func setupViews() {
        [nameLabel, addressLabel].forEach { stackView.addArrangedSubview($0)}
        [cafeImageView, stackView].forEach { contentView.addSubview($0) }
    }
    
    func setupConstraints() {
        cafeImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.width.equalTo(90)
            make.height.equalTo(90)
        }
        
        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(cafeImageView.snp.right).offset(15)
            make.right.equalToSuperview().inset(10)
        }
    }
}
