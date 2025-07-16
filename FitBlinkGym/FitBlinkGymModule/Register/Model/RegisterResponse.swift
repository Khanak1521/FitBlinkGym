//
//  LoginModel.swift
//  FitBlinkGym
//
//  Created by Dipang Sheth on 16/07/25.
//


import Foundation

struct RegisterRequest: Codable {
    let first_name: String
    let last_name: String
    let email: String
    let password: String
    let phone: String
    let country_code: String
    let password_confirmation: String

}



struct RegisterResponse: Codable, Equatable {
    
    let status: Bool?
    let message: String?
    let user: RegisterResponseUser?

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case user = "user"
    }
}

// MARK: - User
struct RegisterResponseUser: Codable, Equatable {
    let firstName: String?
    let lastName: String?
    let email: String?
    let phone: String?
    let countryCode: String?
    let updatedAt: String?
    let createdAt: String?
    let id: Int?
    let otp: Int?
    let otpExpiration: String?

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case email = "email"
        case phone = "phone"
        case countryCode = "country_code"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case id = "id"
        case otp = "otp"
        case otpExpiration = "otp_expiration"
    }
}
