//
//  AuthManager.swift
//  VeriparkApp
//
//  Created by Samet Bugra Oktay on 6.08.2021.
//


import Foundation
import CryptoSwift


final class AuthManager {
    static let shared = AuthManager()
    
    struct Contants {
        static let deviceId = UIDevice.current.identifierForVendor!.uuidString
        static let systemVersion = UIDevice.current.systemVersion
        static let platformName = UIDevice.current.systemName
        static let deviceModel = UIDevice.modelName
        static let manifacturer = "Apple"
        static let handshakeURL = "https://mobilechallenge.veripark.com/api/handshake/start"
    }
    
    enum ApiError: Error {
        case failedToGetData
    }
    
    //verification with handshake method
    func handshake(completion: @escaping (Bool) ->()) {
        guard let url = URL(string: Contants.handshakeURL) else { return }
        
        let body =
            [
                "deviceId": Contants.deviceId,
                "systemVersion": Contants.systemVersion,
                "platformName": Contants.platformName,
                "deviceModel": Contants.deviceModel,
                "manifacturer": Contants.manifacturer
            ]
        
        let bodyData = try? JSONSerialization.data(withJSONObject: body, options: .init())
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("api/handshake/start", forHTTPHeaderField: "POST")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = bodyData
        
        URLSession.shared.dataTask(with: request, completionHandler: {[weak self]data, _, error in
            guard let data = data,
                  error == nil
            else
            {
                completion(false)
                return
            }
            do {
                let result = try JSONDecoder().decode(AuthResponse.self, from: data)
                self?.fetchKeys(result: result)
                
                completion(true)
            }catch {
                completion(false)
            }
        }).resume()
    }
    
    
    private func fetchKeys(result: AuthResponse) {
        UserDefaults.standard.setValue(result.authorization, forKey: "authorization")
        UserDefaults.standard.setValue(result.aesKey, forKey: "aesKey")
        UserDefaults.standard.setValue(result.aesIV, forKey: "aesIV")
    }
}
