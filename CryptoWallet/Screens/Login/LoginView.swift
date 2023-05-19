//
//  LoginVC.swift
//  CryptoWallet
//
//  Created by Назар Ткаченко on 17.04.2023.
//

import UIKit

final class LoginView: UIView {
    
    var onSignIntapped: ((Error?)->())?
    
    //MARK: - Private Properties
    private var keyboardFrame: CGRect = .zero
    private var addTaskViewBottomConstraint: NSLayoutConstraint?
    private let registrationView = RegistrationView(frame: .zero)
    
    //MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        addSubviews()
        setupConstraints()
        addNotifications()
        
        observe()
        
        addTaskViewBottomConstraint = registrationView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        addTaskViewBottomConstraint?.isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        removeNotifications()
    }
    
    //MARK: - Actions
    @objc func onKeyboardWillShow(_ notification: Notification) {
        keyboardFrame = (notification.userInfo?[UITextField.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue ?? .zero
        addTaskViewBottomConstraint?.constant = -keyboardFrame.height
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    @objc func onKeyboardWillHide(_ notification: Notification) {
        keyboardFrame = .zero
        addTaskViewBottomConstraint?.constant = 0
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    //MARK: - Private Methods
    private func setupView() {
        backgroundColor = Colors.background.uiColor
    }
    
    private func addSubviews() {
        addSubview(registrationView)
        registrationView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func addNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(onKeyboardWillShow),
                                               name: UITextField.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(onKeyboardWillHide),
                                               name: UITextField.keyboardWillHideNotification,
                                               object: nil)
    }
    
    private func removeNotifications() {
        NotificationCenter.default.removeObserver(self,
                                                  name: UITextField.keyboardWillShowNotification,
                                                  object: nil)
        
        NotificationCenter.default.removeObserver(self,
                                                  name: UITextField.keyboardWillHideNotification,
                                                  object: nil)
    }
    
    private func observe() {
        registrationView.onSignIntapped = { [weak self] error in
            guard let self = self else { return }
            
            if error != nil {
                self.onSignIntapped?(nil)
            } else {
                self.onSignIntapped?(LoginError.wrongValidation)
            }
        }
    }
}

//MARK: - Setup Constraints
extension LoginView {
    
    private struct Appearance {
        static let padding: CGFloat = 20
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            registrationView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Appearance.padding),
            registrationView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Appearance.padding),
        ])
    }
}
