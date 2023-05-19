//
//  AuthorizationService.swift
//  CryptoWallet
//
//  Created by Назар Ткаченко on 17.05.2023.
//

import Foundation

protocol AuthorizationService {
    func logIn()
    func logOut()
    func isLogIn() -> Bool
}

final class AuthorizationServiceImpl: AuthorizationService {
    
    
    func logIn() {
        UserDefaults.standard.set(true, forKey: "LOGGED_IN")
    }
    
    func logOut() {
        UserDefaults.standard.set(false, forKey: "LOGGED_IN")
    }
    
    func isLogIn() -> Bool {
        UserDefaults.standard.bool(forKey: "LOGGED_IN")
    }
}
