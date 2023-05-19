//
//  CoinResponse.swift
//  CryptoWallet
//
//  Created by Назар Ткаченко on 22.04.2023.
//

// MARK: - Coin
struct CoinResponse: Decodable {
    let data: Coin?
}

// MARK: - DataClass
struct Coin: Decodable {
    let id: String
    let symbol, name, slug: String
    let marketData: MarketData?
    
    enum CodingKeys: String, CodingKey {
        case id
        case symbol, name, slug
        case marketData = "market_data"
    }
}

// MARK: - MarketData
struct MarketData: Decodable {
    let priceUsd: Double?
    let realMarketVolume: Double?
    let indexLastHour: Double?
    let indexLastDay: Double?
    let lastTradeAt: String?
    
    enum CodingKeys: String, CodingKey {
        case priceUsd = "price_usd"
        case realMarketVolume = "real_volume_last_24_hours"
        case indexLastHour = "percent_change_usd_last_1_hour"
        case indexLastDay = "percent_change_usd_last_24_hours"
        case lastTradeAt = "last_trade_at"
    }
}
