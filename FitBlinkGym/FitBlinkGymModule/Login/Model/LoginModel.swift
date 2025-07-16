//
//  LoginModel.swift
//  FitBlinkGym
//
//  Created by Dipang Sheth on 16/07/25.
//


import Foundation

struct LoginRequest: Codable {
    let email: String
    let password: String
}

struct LoginResponse: Codable, Equatable {
    
    let message: String?
    let accessToken: String?
    let refreshToken: String?
    let expiresIn: Int?
    let refreshExpiresIn: Int?
    let status: Bool?
        
    enum CodingKeys: String, CodingKey {
        case message
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case expiresIn = "expires_in"
        case refreshExpiresIn = "refresh_expires_in"
        case status
    }
}
