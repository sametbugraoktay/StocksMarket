//
//  StocksResponse.swift
//  VeriparkApp
//
//  Created by Samet Bugra Oktay on 6.08.2021.
//

import Foundation

struct StocksResponse: Codable {
    let stocks: [Stock]
    let status: Status
}

struct Stock: Codable {
    let id: Int
    let isDown: Bool
    let isUp: Bool
    let bid: Float
    let difference: Float
    let offer: Float
    let price: Float
    let volume: Float
    var symbol: String
    let selectedId : Int
    
}
