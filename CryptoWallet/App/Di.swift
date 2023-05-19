//
//  Di.swift
//  CryptoWallet
//
//  Created by Назар Ткаченко on 02.05.2023.
//

import UIKit

final class Di {
    let coinApiClient: CoinApiClient
    var screenFactory: ScreenFactory
    let router: Router
    let authorizationService: AuthorizationService
    
    init() {
        coinApiClient = CoinApiClientImpl()
        router = RouterImpl()
        authorizationService = AuthorizationServiceImpl()
        
        screenFactory = ScreenFactoryImpl()
        screenFactory.di = self
        
    }
    
    var marketViewModel: MarketViewModelImpl {
        return MarketViewModelImpl.init(coinAPI: coinApiClient, router: router, authorizationService: authorizationService)
    }
    
    var coinViewModel: CoinViewModelImpl {
        return CoinViewModelImpl.init()
    }
    
    var onboardingViewModel: OnboardingViewModelImpl {
        return OnboardingViewModelImpl.init(router: router)
    }
    
    var loginViewModel: LoginViewModelImpl {
        return LoginViewModelImpl.init(router: router, authorizationService: authorizationService)
    }
}
