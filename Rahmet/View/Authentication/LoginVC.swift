//
//  LoginVC.swift
//  Rahmet
//
//  Created by Elvina Shamoi on 12.02.2022.
//
import UIKit
import SwiftKeychainWrapper
import JGProgressHUD

class LoginVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        createConstraints()
    }
    
    let spinner = JGProgressHUD(style: .dark)
    
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
    
    lazy var nextLogin: UIButton = {
        let button = UIButton()
        button.setTitle("Войти", for: .normal)
        button.layer.cornerRadius = 5
        button.backgroundColor = UIColor.init(red: 222/255, green: 45/255, blue: 73/255, alpha: 1)
        button.tintColor = .white
        button.addTarget(self, action: #selector(nextStep), for: .touchUpInside)
        return button
    }()
    
    @objc func nextStep() {
        if let email = emailTextField.text, let password = passwordTextField.text {
            spinner.show(in: view)
            APIClient.login(email: email, password: password) { result in
                switch result {
                case .success(let message):
                    self.spinner.dismiss(animated: true)
                    if let accessToken = message.data?.accessToken, let type = message.data?.tokenType {
                        let saveAccessToken: Bool = KeychainWrapper.standard.set(accessToken, forKey: Constants.tokenKey)
                        print("The access token saved results \(saveAccessToken) \(type) \(accessToken)")
                        print(message)
                        let appDelegate = UIApplication.shared.delegate
                        appDelegate?.window??.rootViewController = UINavigationController(rootViewController: MainTabBarController())
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    self.present(AuthAlertController(description: error.localizedDescription), animated: true, completion: nil)
                    self.spinner.dismiss(animated: true)
                }
            }
        }
    }
    
    
    
    
    
    func setUpViews() {
        view.backgroundColor = .white
        view.addSubview(logoImage)
        [emailTextField, passwordTextField, registrationButton].forEach {
            stackView.addArrangedSubview($0)
        }
        view.addSubview(stackView)
        view.addSubview(nextLogin)
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
        
        nextLogin.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(45)
            make.width.equalTo(170)
            make.bottom.equalToSuperview().inset(50)
        }
    }
}
