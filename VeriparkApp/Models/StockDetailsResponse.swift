//
//  StockDetailsResponse.swift
//  VeriparkApp
//
//  Created by Samet Bugra Oktay on 6.08.2021.
//

import Foundation


struct StockDetailsResponse: Codable {
    let isDown: Bool
    let isUp: Bool
    let bid: Float
    let channge: Float
    let count: Int
    let difference: Float
    let offer: Float
    let highest: Float
    let lowest: Float
    let maximum: Float
    let minimum: Float
    let price: Float
    let volume: Float
    let symbol: String
    let graphicData: [GraphicData]
    let status: Status
    

}

struct GraphicData: Codable {
    let day: Int
    let value: Float
}
