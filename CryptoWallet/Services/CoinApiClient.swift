//
//  CoinApiClientImpl.swift
//  CryptoWallet
//
//  Created by Назар Ткаченко on 23.04.2023.
//

import Foundation

protocol CoinApiClient {
    func fetchCoinsConcurrently(completion: @escaping([CoinResponse], Bool)-> Void)
}

final class CoinApiClientImpl: CoinApiClient {
    
    private var coins = ["btc", "eth", "tron", "polkadot", "dogecoin", "tether", "stellar", "cardano", "xrp"]
    
    func fetchCoinsConcurrently(completion: @escaping([CoinResponse], Bool)-> Void) {
        
        var coinResponses: [CoinResponse] = []
        let group = DispatchGroup()
        let semaphore = DispatchSemaphore(value: 1)
        
        for coin in coins {
            group.enter()
            fetchCoin(name: coin) { data in
                semaphore.wait()
                guard let data = data else { return }
                if data.data != nil {
                    coinResponses.append(data)
                }
                semaphore.signal()
                group.leave()
            }
        }
        group.notify(queue: .main) {
            if coinResponses.count == self.coins.count {
                completion(coinResponses, false)
            } else {
                completion(coinResponses, true)
            }
        }
    }
    
    private func fetchCoin(name: String, completion: @escaping(CoinResponse?)->()) -> Void {
        API.request(endpoint: CoinEndpoint.fetchCoin(name: name), responseModel: CoinResponse.self) { data in
            completion(data)
        }
    }
}
