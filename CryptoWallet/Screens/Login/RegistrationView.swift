//
//  UserAuthenticationDataVC.swift
//  CryptoWallet
//
//  Created by Назар Ткаченко on 19.04.2023.
//

import UIKit

enum LoginError: Error {
    case wrongValidation
}

final class RegistrationView: UIView {
    
    //MARK: - Public Properties
    var onSignIntapped: ((Error?)->())?
    
    //MARK: - Private Properties
    private let headerRegisterLabel = Label(style: .header,
                                            text: Texts.Login.header,
                                            color: Colors.onboardDescriptionText.uiColor)
    
    private let userNameTextField: UITextField = {
        let textField = UITextField()
        
        textField.backgroundColor = .white
        textField.placeholder = Texts.Login.userName
        textField.setIcon(Images.user)
        textField.keyboardType = .default
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        
        textField.backgroundColor = .white
        textField.placeholder = Texts.Login.password
        textField.setIcon(Images.password)
        textField.keyboardType = .default
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private lazy var signInButton = Button(style: .main,
                                           text: Texts.Login.signIn)
    
    //MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        addSubviews()
        setupConstraints()
        
        signInButton.onAction = { [weak self] in
            guard let self = self else { return }
            
            guard let userText = self.userNameTextField.text,
                  let passwordText = self.passwordTextField.text else { return }
            
            if userText == "1234" && passwordText  == "1234" {
                self.onSignIntapped?(nil)
            } else {
                self.onSignIntapped?(LoginError.wrongValidation)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        cornerRadius()
    }
    
    //MARK: - Private Methods
    private func setupView() {
        backgroundColor = Colors.background.uiColor
    }
    
    private func addSubviews() {
        addSubview(headerRegisterLabel)
        addSubview(userNameTextField)
        addSubview(passwordTextField)
        addSubview(signInButton)
    }
    
    private func cornerRadius() {
        userNameTextField.layer.cornerRadius = userNameTextField.bounds.height / 2
        passwordTextField.layer.cornerRadius = passwordTextField.frame.height / 2
        signInButton.layer.cornerRadius = signInButton.frame.height / 2
    }
}

//MARK: - Setup Constraints
extension RegistrationView {
    
    private struct Appearance {
        static let zero: CGFloat = 0
        static let height: CGFloat = 55
        static let padding: CGFloat = 5
        static let userNameTopPadding: CGFloat = 30
        static let passwordTopPadding: CGFloat  = 15
        static let buttonTopPadding: CGFloat  = 25
        static let buttonBottomPadding: CGFloat  = -40
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerRegisterLabel.topAnchor.constraint(equalTo: topAnchor, constant: Appearance.zero),
            headerRegisterLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Appearance.zero),
            headerRegisterLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant:  Appearance.zero),
            
            userNameTextField.topAnchor.constraint(equalTo: headerRegisterLabel.bottomAnchor, constant: Appearance.userNameTopPadding),
            userNameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Appearance.padding),
            userNameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Appearance.padding),
            userNameTextField.heightAnchor.constraint(equalToConstant: Appearance.height),
            
            passwordTextField.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: Appearance.passwordTopPadding),
            passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Appearance.padding),
            passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Appearance.padding),
            passwordTextField.heightAnchor.constraint(equalToConstant: Appearance.height),
            
            signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: Appearance.buttonTopPadding),
            signInButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Appearance.padding),
            signInButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Appearance.padding),
            signInButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Appearance.buttonBottomPadding)
        ])
    }
}
