//
//  CoinViewModel.swift
//  CryptoWallet
//
//  Created by Назар Ткаченко on 13.05.2023.
//

import Foundation

//MARK: - CoinData
struct CoinData {
    let name: String
    let symbol: String
    let price: String
    let indexLastHour: String
    let image: String
    let lastTrade: String
    let marketVolume: String
    let indexLastDay: String
    let icon: Bool
}

protocol CoinViewModel {
    var coin: Coin? { get set }
    var coinsObserver: ((CoinData) -> ())? { get set }
    func сonvert()
}

final class CoinViewModelImpl: CoinViewModel {
    
    //MARK: - Public Properties
    var coin: Coin?
    var coinsObserver: ((CoinData) -> ())?
    
    //MARK: - LifeCycle
    init() {}
    
    //MARK: - Public Methods
    func сonvert() {
        guard let coin = coin else { return }
        guard let index = coin.marketData?.indexLastHour else { return }
        
        var indexIcon: Bool
        
        if index >= 0.0 {
            indexIcon = true
        } else {
            indexIcon = false
        }
        
        let result = CoinData(name: coin.name,
                              symbol: coin.symbol,
                              price: "$" + String(format: "%.4f", coin.marketData?.priceUsd ?? 0),
                              indexLastHour: String(format: "%.4f", index),
                              image: coin.slug,
                              lastTrade: dateFormat(dateString: coin.marketData?.lastTradeAt),
                              marketVolume: "$" + String(Int(coin.marketData?.realMarketVolume ?? 0)),
                              indexLastDay: String(format: "%.4f", coin.marketData?.indexLastDay ?? ""),
                              icon: indexIcon
        )
        
        coinsObserver?(result)
    }
    
    //MARK: - Private Methods
    private func dateFormat(dateString: String?) -> String {
        guard let dateString = dateString else { return "No date" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.setLocalizedDateFormatFromTemplate("yyyy-MM-dd HH:mm:ss")
            let formattedDate = dateFormatter.string(from: date)
            return formattedDate
        } else { return "No date" }
    }
}
