//
//  LoginModel.swift
//  FitBlinkGym
//
//  Created by Dipang Sheth on 16/07/25.
//

import Foundation
import Combine

class LoginViewModel : ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isFormValid: Bool = false
    
    @Published var cancellables: Set<AnyCancellable> = []
    private var apiManager = APIManager()
    
    @Published var loginResponse: LoginResponse?
    @Published var errorMessage: String?
    
    init() {
        Publishers.CombineLatest($email, $password)
            .map {  email, password in
                return self.isValidEmail(email) && self.isValidPassword(password)
            }
            .assign(to: &$isFormValid)
    }
    
    
    private func isValidEmail(_ email: String) -> Bool {
        let regex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: email)
    }
    
    private func isValidPassword(_ password: String) -> Bool {
        return password.count >= 8
    }
    
    func login() {
        
        let requestBody = LoginRequest(email: email, password: password)
        let urlString = APIURL.finalUrl(APIURL.auth.login)
        print(urlString)
        print(requestBody)

        apiManager.postRequest(urlString: urlString, body: requestBody, responseType: LoginResponse.self)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error: \(error)")
                    self.errorMessage = error.localizedDescription
                case .finished:
                    print("Finished")
                }
            }) { loginResponse in
                self.loginResponse = loginResponse
        }.store(in: &cancellables)
    }
}
