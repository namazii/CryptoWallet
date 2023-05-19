//
//  LoginViewModel.swift
//  CryptoWallet
//
//  Created by Назар Ткаченко on 13.05.2023.
//

protocol LoginViewModel {
    var router: Router { get set }
    var authorizationService: AuthorizationService { get set }
    
    func authorization()
    func showNextScreen()
}

final class LoginViewModelImpl: LoginViewModel {
    
    //MARK: - Public Properties
    var router: Router
    var authorizationService: AuthorizationService
    
    //MARK: - LifeCycle
    init(router: Router, authorizationService: AuthorizationService) {
        self.router = router
        self.authorizationService = authorizationService
    }
    
    func authorization() {
        authorizationService.logIn()
    }
    
    func showNextScreen() {
        router.showMarketScreen()
    }
}
