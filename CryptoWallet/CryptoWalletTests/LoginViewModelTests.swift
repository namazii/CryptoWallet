//
//  LoginViewModelTests.swift
//  CryptoWalletTests
//
//  Created by Назар Ткаченко on 19.05.2023.
//

import XCTest
@testable import CryptoWallet

final class LoginViewModelTests: XCTestCase {
    
    var authorizationService: AuthorizationServiceSpy!
    var router: RouterSpy!
    var sut: LoginViewModel!
    
    override func setUp() {
        super.setUp()
        
        router = RouterSpy()
        authorizationService = AuthorizationServiceSpy()
        sut = LoginViewModelImpl(router: router, authorizationService: authorizationService)
    }
    
    override func tearDown() {
        
        router = nil
        authorizationService = nil
        sut = nil
        
        super.tearDown()
    }
    
    func testShowMarketScreenShouldReturnTrueWhenItsCalled() {
        sut.showNextScreen()
        
        XCTAssert(router.showMarketScreenCalled, "showNextScreen() should ask the Router to return true when it will be called")
    }
}
