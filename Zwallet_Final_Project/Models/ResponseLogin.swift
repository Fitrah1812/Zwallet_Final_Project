//
//  ResponseLogin.swift
//  Zwallet_Final_Project
//
//  Created by Laptop MCO on 12/08/23.
//

import Foundation

struct ResponseLogin: Codable {
    let status: Int
    let message: String
    let data: Data
    
    struct Data: Codable {
        let hasPin: Bool
        let id: Int
        let email, token: String
        let expiredIn, expiredAt: Int
        let refreshToken: String
        let refreshTokenExpiredIn, refreshTokenExpiredAt: Int
        
        enum CodingKeys: String, CodingKey {
            case hasPin, id, email, token
            case expiredIn = "expired_in"
            case expiredAt = "expired_at"
            case refreshToken
            case refreshTokenExpiredIn = "refreshToken_expired_in"
            case refreshTokenExpiredAt = "refreshToken_expired_at"
        }
    }
}


