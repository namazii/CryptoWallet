//
//  OnboardingViewModelTests.swift
//  CryptoWalletTests
//
//  Created by Назар Ткаченко on 19.05.2023.
//

import XCTest
@testable import CryptoWallet

final class OnboardingViewModelTests: XCTestCase {
    
    var router: RouterSpy!
    var sut: OnboardingViewModel!
    
    override func setUp() {
        super.setUp()
        
        router = RouterSpy()
        sut = OnboardingViewModelImpl(router: router)
    }
    
    override func tearDown() {
        
        sut = nil
        router = nil
        
        super.tearDown()
    }
    
    
    func testNextScreenShouldReturnTrueWhenCalled() {
        sut.showNextScreen()
        
        XCTAssert(router.showLoginScreenCalled, "showNextScreen() should ask the Router to return true when it will be called")
    }
}
