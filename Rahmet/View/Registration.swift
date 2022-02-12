//
//  SignUpView.swift
//  Rahmet
//
//  Created by Elvina Shamoi on 07.02.2022.
//

import UIKit
import SnapKit

class Registration: UIViewController {
    
    var email = ""
    var password = ""
    var isPassword = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        createConstraints()
    }
    
    var mainLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    var subMainLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    var submessageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    var textField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 5
        textField.borderStyle = .roundedRect
        textField.layer.borderWidth = 0.3
        textField.font = .boldSystemFont(ofSize: 16)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height)) // to make padding in placeholder
        textField.leftViewMode = .always
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return textField
    }()
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField == textField, let txt = textField.text {
            if (txt.isValidEmail && !isPassword) || (isPassword && txt.count >= 9){
                if isPassword {
                    password = txt
                } else {
                    email = txt
                }
                nextButton.backgroundColor = UIColor.init(red: 222/255, green: 45/255, blue: 73/255, alpha: 1)
                nextButton.tintColor = .white
                nextButton.isEnabled = true
            }
        }
    }
    
    var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Далее", for: .normal)
        button.tintColor = .darkGray
        button.isEnabled = false
        button.layer.cornerRadius = 5
        button.backgroundColor = .gray
        button.addTarget(self, action: #selector(nextStep), for: .touchUpInside)
        return button
    }()
    
    var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Войти по e-mail", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(openLoginVC), for: .touchUpInside)
        return button
    }()
    
    @objc func openLoginVC() {
        let vc = LoginVC()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 15
        stackView.axis = .vertical
        return stackView
    }()
    
    var agreementsText: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.dataDetectorTypes = .link
        let attributesForUnderLine: [NSAttributedString.Key: Any] = [
                    .font: UIFont.systemFont(ofSize: 12),
                    .underlineStyle: NSUnderlineStyle.single.rawValue,
                    .link: NSURL(string: "https://rahmetapp.kz/files/app/agreement.html")!
        ]
        textView.linkTextAttributes = [.foregroundColor: UIColor.gray]
        let attributesForNormalText: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 12),
            .foregroundColor: UIColor.gray
        ]
        let agreementsLine = "Нажимая “Далее”, вы принимаете\n условия публичной оферты"
        let rangeOfUnderLine = (agreementsLine as NSString).range(of: "условия публичной оферты")
        let rangeOfNormalText = (agreementsLine as NSString).range(of: "Нажимая “Далее”, вы принимаете\n")
        let attributedText = NSMutableAttributedString(string: agreementsLine)
        attributedText.addAttributes(attributesForUnderLine, range: rangeOfUnderLine)
        attributedText.addAttributes(attributesForNormalText, range: rangeOfNormalText)
        textView.attributedText = attributedText
        textView.textAlignment = .center
        return textView
    }()
    
    var backbutton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "back.png"), for: .normal)
        button.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        return button
    }()

    
    @objc func nextStep() {
        if password != "" && password.count >= 9 && email != "" && isPassword{
            print(email, password)
        } else if password.count < 9 && isPassword {
            let alert = UIAlertController(title: "Ошибка", message: "Пароль должен состоять минимум из 9 символов", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Понятно", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            setUpPasswordView()
        }
    }
    
    func setUpPasswordView() {
        isPassword = true
        backbutton.isHidden = false
        textField.isSecureTextEntry = true
        email = textField.text ?? ""
        textField.text = password
        mainLabel.text = "Введите пароль"
        subMainLabel.text = "Пароль должен состоять минимум из 9 символов"
        submessageLabel.text = "Пароль"
        textField.placeholder = "Введите пароль"
    }
    
    func setUpEmailView() {
        backbutton.isHidden = true
        isPassword = false
        password = textField.text ?? ""
        textField.text = email
        textField.isSecureTextEntry = false
        mainLabel.text = "Регистрация"
        subMainLabel.text = "Введите ваш почтовый адрес"
        submessageLabel.text = "e-mail"
        textField.placeholder = "Введите почтовый адрес"
    }
    
    func setUpViews() {
        setUpEmailView()
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backbutton)
        backbutton.isHidden = true
        [mainLabel, subMainLabel, submessageLabel, textField, loginButton, agreementsText].forEach {stackView.addArrangedSubview($0)}
        view.addSubview(stackView)
        view.addSubview(nextButton)
    }
    
    @objc func backAction() {
        setUpEmailView()
    }
    
    func createConstraints() {
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.screenHeight / 5)
            make.left.right.equalToSuperview().inset(15)
        }
        
        textField.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        agreementsText.snp.makeConstraints { make in
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


//import SwiftUI
//struct LoginVCProvider: PreviewProvider {
//    static var previews: some View {
//        ContainerView().edgesIgnoringSafeArea(.all)
//    }how
//    struct ContainerView: UIViewControllerRepresentable {
//        let loginVC = Registration()
//        func makeUIViewController(context: Context) -> some UIViewController {
//            return loginVC
//        }
//        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
//        }
//    }
//}
