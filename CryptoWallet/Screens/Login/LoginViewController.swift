//
//  LoginViewController.swift
//  CryptoWallet
//
//  Created by Назар Ткаченко on 16.05.2023.
//

import UIKit

final class LoginViewController: UIViewController {
    
    //MARK: - Private Properties
    private var viewModel: LoginViewModel
    private var rootView: LoginView { return self.view as! LoginView }
    
    //MARK: - LifeCycle
    init(loginViewModel: LoginViewModel) {
        self.viewModel = loginViewModel
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        view = LoginView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        observe()
    }
    
    private func observe() {
        rootView.onSignIntapped = { [weak self] error in
            guard let self = self else { return }
            
            if error != nil {
                self.viewModel.authorization()
                self.viewModel.showNextScreen()
            } else {
                self.showAlert(title: Texts.Login.titleAlert, message: Texts.Login.messageAlert)
            }
        }
    }
}
