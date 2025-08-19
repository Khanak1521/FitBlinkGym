//
//  APIManager.swift
//  FitBlinkGym
//
//  Created by Dipang Sheth on 16/07/25.
//

import Foundation
import Combine
import SwiftUI

protocol APIManagerProtocol {
    func fetchRequest<T:Decodable>( urlString: String, responseType: T.Type) -> AnyPublisher<[T], APIError>
    func postRequest<T:Decodable, U:Encodable>( urlString: String, body: U, responseType: T.Type) -> AnyPublisher<T, APIError>
}

class APIManager : APIManagerProtocol {
    
    private func apiHeaders(to request: inout URLRequest) {
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        if let token: String = AuthManager.fetch("token") {
             request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
    }
    
    func postRequest<T:Decodable, U:Encodable>( urlString: String, body: U, responseType: T.Type) -> AnyPublisher<T, APIError> {
        
        guard let url = URL(string: urlString) else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        apiHeaders(to: &urlRequest)
        urlRequest.httpBody = try? JSONEncoder().encode(body)
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { data, response in
                
                if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                    print(httpResponse)
                    throw APIError.serverError(httpResponse.statusCode)
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError {
                if let error = $0 as? APIError {
                    return error
                } else if let decodingError = $0 as? DecodingError {
                    return .decodingError(decodingError)
                } else {
                    return .unknown($0)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    
    func fetchRequest<T:Decodable>( urlString: String, responseType: T.Type) -> AnyPublisher<[T], APIError> {
        
        guard let url = URL(string: urlString) else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        apiHeaders(to: &urlRequest)

        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { (data, response) -> Data in
                if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                    print(response)
                    throw APIError.serverError(httpResponse.statusCode)
                }
                
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                    print(jsonObject)
                    } catch {
                        print("❌ JSON parsing error: \(error)")
                    }
                
                return data
            }
            .decode(type: [T].self, decoder: JSONDecoder())
            .mapError {
                if let error = $0 as? APIError {
                    return error
                } else if let decodingError = $0 as? DecodingError {
                    return .decodingError(decodingError)
                } else {
                    return .unknown($0)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
