//
//  LoginModel.swift
//  FitBlinkGym
//
//  Created by Dipang Sheth on 16/07/25.
//


/*
import Foundation

struct GymList: Codable {
    let gyms: [GymListGym]?
    let status: Int?
}

struct GymListGym: Codable {
    let id: Int?
    let gymName: String?
    let gymEmail: String?
    let gymPhone: Int?
    let address1: String?
    let address2: String?
    let city: String?
    let pincode: Int?
    let latitude: String?
    let longitude: String?
    let logo: String?
    let countryCode: String?
    let countryId: Int?
    let stateId: Int?
    let isDefault: Int?
    let createdAt: String?
    let updatedAt: String?
    let createdBy: Int?
    let updatedBy: String?
    let status: String?

    enum CodingKeys: String, CodingKey {
        case id
        case gymName = "gym_name"
        case gymEmail = "gym_email"
        case gymPhone = "gym_phone"
        case address1
        case address2
        case city
        case pincode
        case latitude
        case longitude
        case logo
        case countryCode = "country_code"
        case countryId = "country_id"
        case stateId = "state_id"
        case isDefault = "is_default"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case createdBy = "created_by"
        case updatedBy = "updated_by"
        case status
    }
}
*/

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - WelcomeElement
struct UserList: Identifiable, Codable, Hashable {
    let id: Int?
    let name: String?
    let username: String?
    let email: String?
    let address: userAddress?
    let phone: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case username
        case email
        case address
        case phone
    }
}

// MARK: - Address
struct userAddress: Codable, Hashable {
    let street: String?
    let city: String?
    let zipcode: String?
    var fullAddress: String? {
        return "\(self.street ?? "") \(self.city ?? "") \(self.zipcode ?? "")"
    }

    enum CodingKeys: String, CodingKey {
        case street
        case city
        case zipcode
    }
}
