//
//  RahmetVC.swift
//  Rahmet
//
//  Created by Arman on 09.02.2022.
//

import UIKit
import SwiftKeychainWrapper


class RahmetVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Выйти", for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(logoutClicked), for: .touchUpInside)
        button.backgroundColor = UIColor.init(red: 222/255, green: 45/255, blue: 73/255, alpha: 1)
        button.layer.cornerRadius = 15
        return button
    }()
    
    @objc func logoutClicked() {
        APIClient.logout { result in
            switch result {
            case .success(let message):
                print(message)
                KeychainWrapper.standard.removeObject(forKey: Constants.tokenKey)
                let appDelegate = UIApplication.shared.delegate
                appDelegate?.window??.rootViewController = UINavigationController(rootViewController: Registration())
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func setupViews() {
        view.addSubview(logoutButton)
    }
    
    func setupConstraints() {
        logoutButton.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(180)
        }
    }
}
