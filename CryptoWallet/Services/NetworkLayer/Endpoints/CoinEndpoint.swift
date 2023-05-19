//
//  CoinEndpoint.swift
//  CryptoWallet
//
//  Created by Назар Ткаченко on 23.04.2023.
//

import Foundation

enum CoinEndpoint: Endpoint {
    
    case fetchCoin(name: String)
    
    var sheme: String {
        switch self {
        default:
            return "https"
        }
    }
    
    var baseURL: String {
        switch self {
        default:
            return "data.messari.io"
        }
    }
    
    var path: String {
        switch self {
        case .fetchCoin(name: let name):
            return "/api/v1/assets/\(name)/metrics"
        }
    }
    
    var parameters: [URLQueryItem] { return [] }
    
    var method: String {
        switch self {
        case.fetchCoin:
            return "GET"
        }
    }
}
