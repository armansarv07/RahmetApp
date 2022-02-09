//
//  Login.swift
//  Rahmet
//
//  Created by Elvina Shamoi on 09.02.2022.
//

import UIKit

class LoginVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        createConstraints()
    }
    
    var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 15
        stackView.axis = .vertical
        return stackView
    }()
    
    var logoImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage.init(named: "logo.png")
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    var emailTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 5
        textField.borderStyle = .roundedRect
        textField.layer.borderWidth = 0.3
        textField.font = .boldSystemFont(ofSize: 16)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.placeholder = "Введите почтовый адрес"
        textField.leftViewMode = .always
        return textField
    }()
    
    var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 5
        textField.borderStyle = .roundedRect
        textField.layer.borderWidth = 0.3
        textField.font = .boldSystemFont(ofSize: 16)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.placeholder = "Введите пароль"
        textField.leftViewMode = .always
        return textField
    }()
    
    var registrationButton: UIButton = {
        let button = UIButton()
        button.setTitle("Зарегистрироваться", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(openRegistrationVC), for: .touchUpInside)
        return button
    }()
    
    @objc func openRegistrationVC() {
        self.dismiss(animated: true)
    }
    
    var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Войти", for: .normal)
        button.isEnabled = false
        button.layer.cornerRadius = 5
        button.backgroundColor = UIColor.init(red: 222/255, green: 45/255, blue: 73/255, alpha: 1)
        button.tintColor = .white
        button.addTarget(self, action: #selector(nextStep), for: .touchUpInside)
        return button
    }()
    
    @objc func nextStep() {
        print("ok")
    }
    
    func setUpViews() {
        view.backgroundColor = .white
        view.addSubview(logoImage)
        [emailTextField, passwordTextField, registrationButton].forEach {
            stackView.addArrangedSubview($0)
        }
        view.addSubview(stackView)
        view.addSubview(nextButton)
    }
    
    
    func createConstraints() {
        logoImage.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(0)
            make.width.equalTo(Constants.screenWidth * 0.8)
            make.centerX.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(logoImage.snp.bottom).inset(Constants.screenHeight / 7)
            make.left.right.equalToSuperview().inset(15)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        nextButton.snp.makeConstraints { make in
            make.width.equalTo(170)
            make.height.equalTo(45)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(50)
        }
    }
}
