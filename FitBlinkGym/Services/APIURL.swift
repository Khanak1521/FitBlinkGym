//
//  APIEndpoints.swift
//  FitBlinkGym
//
//  Created by Dipang Sheth on 16/07/25.
//

import Foundation
import Combine

enum APIError: Error {
    case invalidURL
    case decodingError(Error)
    case serverError(Int)
    case internetConnectionError
    case unknown(Error)
}

enum APIURL {
    
    static let baseUrl = "https://api.fitblinkgym.com/api/"
    
    enum auth {
        static let login = "login"
        static let register = "register"
        static let verify = "verify"
    }
    
    static func finalUrl(_ path: String) -> String {
            return baseUrl + path
    }
}
