//
//  APIManager.swift
//  FitBlinkGym
//
//  Created by Dipang Sheth on 16/07/25.
//

import Foundation
import Combine

class APIManager {
        
    
    func postRequest<T:Decodable, U:Encodable>( urlString: String, method: String = "POST", body: U, responseType: T.Type) -> AnyPublisher<T, APIError> {
        
        guard let url = URL(string: urlString) else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("application/json", forHTTPHeaderField: "accept")
        urlRequest.httpBody = try? JSONEncoder().encode(body)
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { data, response in
                
                if let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) {
                    print(httpResponse)
                    throw APIError.serverError(httpResponse.statusCode)
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                if error is DecodingError {
                    return .decodingError(error)
                }
                else if error is URLError {
                    return .invalidURL
                }
                else {
                    return .unknown(error)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}
