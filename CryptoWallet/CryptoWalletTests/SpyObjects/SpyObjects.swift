//
//  SpyObjects.swift
//  CryptoWalletTests
//
//  Created by Назар Ткаченко on 18.05.2023.
//

import UIKit
@testable import CryptoWallet

//MARK: - CoinApiClient
final class CoinApiClientSpy: CoinApiClient {
    
    var resultResponse: [CoinResponse]!
    
    var fetchCoinsConcurrentlyCalled = false
    func fetchCoinsConcurrently(completion: @escaping ([CryptoWallet.CoinResponse], Bool) -> Void) {
        fetchCoinsConcurrentlyCalled = true
    }
}

//MARK: - Router
final class RouterSpy: Router {
    
    var showCoinScreenCalled = false
    func showCoinScreen(_ coin: CryptoWallet.Coin, from: UIViewController) {
        showCoinScreenCalled  = true
    }
    
    var showMarketScreenCalled = false
    func showMarketScreen() {
        showMarketScreenCalled = true
    }
    
    var showLoginScreenCalled = false
    func showLoginScreen() {
        showLoginScreenCalled = true
    }
    
    var logOutCalled = false
    func logOut() {
        logOutCalled = true
    }
}

//MARK: - AuthorizationService
final class AuthorizationServiceSpy: AuthorizationService {
    
    var logInCalled = false
    func logIn() {
        logInCalled = true
    }
    
    var logOutCalled = false
    func logOut() {
        logOutCalled = true
    }
    
    var isLogInCalled = false
    func isLogIn() -> Bool {
        isLogInCalled = true
        return false
    }
}
