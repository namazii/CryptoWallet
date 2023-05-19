//
//  OnboardingViewModel.swift
//  CryptoWallet
//
//  Created by Назар Ткаченко on 14.05.2023.
//

protocol OnboardingViewModel {
    var router: Router { get set }
    func showNextScreen()
}

final class OnboardingViewModelImpl: OnboardingViewModel {
    
    //MARK: - Public Properties
    var router: Router
    
    //MARK: - LifeCycle
    init(router: Router) {
        self.router = router
    }
    
    func showNextScreen() {
        router.showLoginScreen()
    }
}
