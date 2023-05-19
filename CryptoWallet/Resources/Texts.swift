//
//  Texts.swift
//  CryptoWallet
//
//  Created by Назар Ткаченко on 28.04.2023.
//

enum Texts {
    
    // MARK: - Onboarding
    enum Onboarding {
        static let firstHeader = "Welcome to Cryptol!"
        static let firstDescription = "You can manage all your crypto assets in one place with Cryptol!"
        static let secondHeader = "All in one wallet"
        static let secondDescription = "Hodl, Bitcoin, Etherium, XRP, Doge, alt coins and many other coins"
        static let thirdHeader = "Security and Reliability"
        static let thirdDescription = "Send and receive cryptocurrency daily, simply, safely and securely"
        static let close = "Close"
    }
    
    // MARK: - Login
    enum Login {
        static let header = "Authorization"
        static let userName = "Username"
        static let password = "Password"
        static let signIn = "Sign in"
        static let titleAlert = "Authentication Error"
        static let messageAlert = "Check the correctness of the login and password"
    }
    
    // MARK: - Market
    enum Market {
        static let sort = "Sort"
        static let exit = "Exit"
        static let navTitle = "Market"
        static let alertTitle = "Request limit exceeded"
        static let alertMessage = "Please try again in 1 minute"
    }
    
    //MARK: - Coin
    enum Coin {
        static let header = "MarketStatistic"
        static let lastUpdate = "Last update trade"
        static let volume = "Market Volume"
        static let index = "Coin index for 24H"
    }
}
