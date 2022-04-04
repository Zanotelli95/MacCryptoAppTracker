//
//  Crypto.swift
//  CryptoTracker
//
//  Created by Fabian Zanotelli Oviedo on 03/04/22.
//

import Foundation

// MARK: - Crypto
struct Crypto: Codable {
    let symbol: String
    let price24H, volume24H, lastTradePrice: Double

    enum CodingKeys: String, CodingKey {
        case symbol
        case price24H = "price_24h"
        case volume24H = "volume_24h"
        case lastTradePrice = "last_trade_price"
    }
}
