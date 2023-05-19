//
//  MarketViewModel.swift
//  CryptoWallet
//
//  Created by Назар Ткаченко on 07.05.2023.
//

import UIKit

protocol MarketViewModel {
    func fetchCoins()
    func sortData()
    func logOut()
    func showOnboardingScreen()
    func showNextScreen(coin: Coin, from: UIViewController)
    
    var coins: [CoinResponse] { get set }
    var coinsChanged: (([CoinResponse]) -> ())? { get set }
    var needAlert: ((Bool) -> ())? { get set }
}

final class MarketViewModelImpl: MarketViewModel {
    
    //MARK: - Public Properties
    var coinsChanged: (([CoinResponse]) -> ())?
    var needAlert: ((Bool) -> ())?
    var coins: [CoinResponse] = []
    
    //MARK: - Private Properties
    private let coinAPI: CoinApiClient
    private var router: Router
    private var authorizationService: AuthorizationService
    
    private var isSorted = false
    private var loadedData = false
    
    //MARK: - LifeCycle
    init(coinAPI: CoinApiClient, router: Router, authorizationService: AuthorizationService) {
        self.coinAPI = coinAPI
        self.router = router
        self.authorizationService = authorizationService
    }
    
    //MARK: - Public Methods
    func fetchCoins() {
        coinAPI.fetchCoinsConcurrently { [weak self] coins, error in
            
            guard let self = self else { return }
            
            if self.loadedData == true {
                self.coins = self.refreshDataCoin(coins: coins)
                self.coinsChanged?(self.coins)
            } else {
                self.coins = coins
                self.loadedData = true
                self.coinsChanged?(self.coins)
            }
            
            if error { self.needAlert?(error)}
        }
    }
    
    func showNextScreen(coin: Coin, from: UIViewController) {
        router.showCoinScreen(coin, from: from)
    }
    
    func sortData() {
        if !coins.isEmpty {
            coins.sort { first, second in
                
                guard let first = first.data?.marketData?.indexLastHour else { return !isSorted }
                guard let second = second.data?.marketData?.indexLastHour else { return isSorted}
                
                if isSorted {
                    return first > second
                } else {
                    return first < second
                }
            }
            isSorted.toggle()
            coinsChanged?(coins)
        }
    }
    
    func showOnboardingScreen() {
        router.logOut()
    }
    
    func logOut() {
        authorizationService.logOut()
    }
    
    //MARK: - Private Methods
    private func refreshDataCoin(coins: [CoinResponse]) -> [CoinResponse] {
        var result = [CoinResponse]()
        
        if self.coins.count > coins.count {
            for coin in self.coins {
                if let firstCoin = coins.first(where: { $0.data?.id == coin.data?.id }) {
                    result.append(firstCoin)
                } else {
                    result.append(coin)
                }
            }
        } else {
            result = coins
        }
        
        return result
    }
}
