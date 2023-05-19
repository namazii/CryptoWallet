//
//  ScreenFactory.swift
//  CryptoWallet
//
//  Created by Назар Ткаченко on 07.05.2023.
//

import UIKit

protocol ScreenFactory {
    
    var di: Di! { get set }
    
    func makeOnboardingScreen() -> OnboardingViewController
    func makeLoginScreen() -> LoginViewController
    func makeMarketScreen() -> MarketViewController
    func makeCoinScreen(coin: Coin) -> CoinViewController
}

final class ScreenFactoryImpl: ScreenFactory {
    
    weak var di: Di!
    
    func makeOnboardingScreen() -> OnboardingViewController {
        return OnboardingViewController(onboardingViewModel: di.onboardingViewModel)
    }
    
    func makeLoginScreen() -> LoginViewController {
        return LoginViewController(loginViewModel: di.loginViewModel)
    }
    
    func makeMarketScreen() -> MarketViewController {
        return MarketViewController(marketViewModel: di.marketViewModel)
    }
    
    func makeCoinScreen(coin: Coin) -> CoinViewController {
        return CoinViewController(coinViewModel: di.coinViewModel, coin: coin)
    }
}
