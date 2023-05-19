//
//  MarketViewModelTests.swift
//  CryptoWalletTests
//
//  Created by Назар Ткаченко on 17.05.2023.
//

import XCTest
@testable import CryptoWallet

final class MarketViewModelTests: XCTestCase {
    
    var sut: MarketViewModel!
    var coinApiClient: CoinApiClientSpy!
    var router: RouterSpy!
    var authorizationService: AuthorizationServiceSpy!
    
    override func setUp() {
        super.setUp()
        
        coinApiClient = CoinApiClientSpy()
        router = RouterSpy()
        authorizationService = AuthorizationServiceSpy()
        sut = MarketViewModelImpl(coinAPI: coinApiClient, router: router, authorizationService: authorizationService)
    }
    
    override func tearDown() {
        
        coinApiClient = nil
        router = nil
        authorizationService = nil
        sut = nil
        
        super.tearDown()
    }
    
    func testShowNextScreenShouldReturnTrueWhenItsCalled() {
        
        sut.showNextScreen(coin: Coin(id: "", symbol: "", name: "", slug: "", marketData: nil), from: UIViewController())
        
        XCTAssert(router.showCoinScreenCalled, "showNextScreen() should ask the Router to return true when it will be called")
    }
    
    func testShowOnboardingScreenShouldReturnTrueWhenItsCalled() {
        sut.showOnboardingScreen()
        
        XCTAssert(router.logOutCalled, "showOnboardingScreen() should ask the Router to return true when it will be called")
    }
    
    func testLogoutShouldReturnTrueWhenItsCalled() {
        sut.logOut()
        
        XCTAssert(authorizationService.logOutCalled, "Logout() should ask the authorizationService to logOut")
    }
    
    func testSortDataShouldReturnTrueIfSucsessfulSorted() {
        sut.coins.append(CoinResponse(data: Coin(id: "1", symbol: "", name: "", slug: "", marketData:
                                                    MarketData(priceUsd: 0.1, realMarketVolume: 0.1, indexLastHour: 1.1, indexLastDay: 0.1, lastTradeAt: ""))))
        
        sut.coins.append(CoinResponse(data: Coin(id: "2", symbol: "", name: "", slug: "", marketData:
                                                    MarketData(priceUsd: 0.1, realMarketVolume: 0.1, indexLastHour: 2.1, indexLastDay: 0.1, lastTradeAt: ""))))
        
        sut.coins.append(CoinResponse(data: Coin(id: "3", symbol: "", name: "", slug: "", marketData:
                                                    MarketData(priceUsd: 0.1, realMarketVolume: 0.1, indexLastHour: 3.1, indexLastDay: 0.1, lastTradeAt: ""))))
        
        sut.sortData()
        
        let trueArray = ["1", "2", "3"]
        var counter = 0
        
        for (index, coin) in sut.coins.enumerated() {
            if coin.data?.id == trueArray[index] {
                counter += 1
            }
        }
        
        XCTAssert(counter == trueArray.count, "sortData() should sort array sucsessfuly")
    }
    
    func testFetchCoinsShouldReturnTrueWhenItsCalled() {
        
        sut.fetchCoins()
        
        XCTAssert(coinApiClient.fetchCoinsConcurrentlyCalled, "fetchCoins() should ask the coinApiClient to fetch response")
    }
}
