//
//  Endpoint.swift
//  CryptoWallet
//
//  Created by Назар Ткаченко on 22.04.2023.
//

import Foundation

protocol Endpoint {
    
    var sheme: String { get }
    
    var baseURL: String { get }
    
    var path: String { get }
    
    var parameters: [URLQueryItem] { get }
    
    var method: String { get }
}
