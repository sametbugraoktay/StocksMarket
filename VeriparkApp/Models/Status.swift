//
//  Status.swift
//  VeriparkApp
//
//  Created by Samet Bugra Oktay on 6.08.2021.
//

import Foundation

struct Status: Codable {
    let isSuccess: Bool
    let error: ErrorResponse
}

struct ErrorResponse: Codable {
    let code: Int
    let message: String?
}
