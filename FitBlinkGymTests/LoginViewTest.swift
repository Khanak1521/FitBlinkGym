//
//  LoginViewTest.swift
//  FitBlinkGymTests
//
//  Created by Dipang Sheth on 17/07/25.
//

import XCTest
import Combine

@testable import FitBlinkGym

class MockLoginAPI: APIManagerProtocol {
    
    var shouldReturnError = false
    var response: LoginResponse?
    
    func postRequest<T, U>(urlString: String, body: U, responseType: T.Type) -> AnyPublisher<T, FitBlinkGym.APIError> where T : Decodable, U : Encodable {
        
        if shouldReturnError {
            return Fail(error: .serverError(401)).eraseToAnyPublisher()
        }
        
        let result = response ?? LoginResponse(message: "", accessToken: "", refreshToken: "", expiresIn: 0, refreshExpiresIn: 0, status: true)
        return Just(result)
            .tryMap { value in
                guard let typedValue = value as? T else {
                    throw APIError.decodingError(
                        NSError(domain: "MockLoginAPI", code: -1, userInfo: [
                            NSLocalizedDescriptionKey: "Type mismatch: Expected \(T.self)"
                        ])
                    )
                }
                return typedValue
            }
            .mapError { $0 as? APIError ?? .unknown($0) }
            .eraseToAnyPublisher()
    }
}


final class LoginViewModelTests: XCTestCase {

    var viewModel: LoginViewModel!
    var mockAPI: MockLoginAPI!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockAPI = MockLoginAPI()
        viewModel = LoginViewModel(apimanager: mockAPI)
        cancellables = []
    }

    override func tearDown() {
        viewModel = nil
        mockAPI = nil
        cancellables = nil
        super.tearDown()
    }

    func testLoginSuccess() {
        // Given
        mockAPI.shouldReturnError = false
        let expectation = self.expectation(description: "Login Succeeds")

        viewModel.$loginResponse
            .dropFirst()
            .sink { response in
                XCTAssertNotNil(response)
                XCTAssertEqual(response?.status, true)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        // When
        viewModel.login()

        wait(for: [expectation], timeout: 1)
    }

    func testLoginFailure() {
        // Given
        mockAPI.shouldReturnError = true
        let expectation = self.expectation(description: "Login Fails")

        viewModel.$errorMessage
            .dropFirst()
            .sink { error in
                XCTAssertNotNil(error)
                XCTAssertTrue(error?.contains("Login failed") ?? false)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        // When
        viewModel.login()

        wait(for: [expectation], timeout: 1)
    }
}
