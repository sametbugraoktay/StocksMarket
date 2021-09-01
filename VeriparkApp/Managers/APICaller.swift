//
//  APICaller.swift
//  VeriparkApp
//
//  Created by Samet Bugra Oktay on 6.08.2021.
//


import Foundation
import CryptoSwift

class APICaller {
    
    static let shared = APICaller()
    
    struct Constant {
        static let stocksURL = "https://mobilechallenge.veripark.com/api/stocks/list"
        static let detailsURL = "https://mobilechallenge.veripark.com/api/stocks/detail"
    }
    private var aesKey: String? {
        return UserDefaults.standard.string(forKey: "aesKey")
    }
    private var aesIV: String? {
        return UserDefaults.standard.string(forKey: "aesIV")
    }
    private var authorization: String? {
        return UserDefaults.standard.string(forKey: "authorization")
    }
    
    
    //fetch all stocks
    func fetchStocks(period: String, completion: @escaping (Result<[Stock], Error>) ->()) {
        
        guard let url = URL(string: Constant.stocksURL) else {return}
        
        let body =
            [
                "period": period.aesEncryption()
            ]
        
        let bodyData = try? JSONSerialization.data(withJSONObject: body, options: .init())
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("api/handshake/start", forHTTPHeaderField: "POST")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(authorization, forHTTPHeaderField: "X-VP-Authorization")
        request.httpBody = bodyData
        
        URLSession.shared.dataTask(with: request, completionHandler: {data, _, error in
            guard let data = data, error == nil else {return}
            do {
                let stocksResponse = try JSONDecoder().decode(StocksResponse.self, from: data)
                
                let stocks = stocksResponse.stocks.map({ (stock) -> Stock in
                    var modified = stock
                    modified.symbol = stock.symbol.aesDecrypt()
                    return modified
                })
                completion(.success(stocks))
            }catch
            {
                completion(.failure(error))
            }
        }).resume()
    }
    
    //get stock market details.
    func getDetailsStock(with id: String, completion: @escaping (Result<StockDetailsResponse, Error>) ->()) {
        
        guard let url = URL(string: Constant.detailsURL) else {return}
        
        let body = [
            
            "id": id.aesEncryption()
        ]
        
        let bodyData = try? JSONSerialization.data(withJSONObject: body, options: .init())
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("api/handshake/start", forHTTPHeaderField: "POST")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(authorization, forHTTPHeaderField: "X-VP-Authorization")
        request.httpBody = bodyData
        
        URLSession.shared.dataTask(with: request, completionHandler: {data, _, error in
            guard let data = data, error == nil else {return}
            do {
                let result = try JSONDecoder().decode(StockDetailsResponse.self, from: data)
                completion(.success(result))
            }catch
            {
                completion(.failure(error))
            }
        }).resume()
    }
}
