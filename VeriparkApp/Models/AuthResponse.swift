//
//  AuthResponse.swift
//  VeriparkApp
//
//  Created by Samet Bugra Oktay on 6.08.2021.
//

import Foundation

struct AuthResponse: Codable {
    let aesKey: String
    let aesIV: String
    let authorization: String
    let lifeTime: String
    let status: Status
}
