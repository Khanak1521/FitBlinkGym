//
//  LoginModel.swift
//  FitBlinkGym
//
//  Created by Dipang Sheth on 16/07/25.
//

import Foundation
import Combine

class RegisterViewModel : ObservableObject {
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""

    @Published var countryCode: String = ""
    @Published var phoneNumber: String = ""
    @Published var isFormValid: Bool = false
    
    @Published var cancellables: Set<AnyCancellable> = []
    private var apiManager = APIManager()
    
    @Published var registerResponse: RegisterResponse?
    @Published var errorMessage: String?
    
    init() {
        
        Publishers.CombineLatest3($firstName, $lastName, $email)
            .combineLatest( Publishers.CombineLatest3($password, $countryCode, $phoneNumber) )
            .map { names, passwordCode in
                let (firstName, lastName, email) = names
                let (password, countryCode, phoneNumber) = passwordCode
                
                return !firstName.isEmpty && !lastName.isEmpty && self.isValidEmail(email) && self.isValidPassword(password) &&  (countryCode.count + phoneNumber.count) == 12
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
    
    func register() {
        
        let requestBody = RegisterRequest(first_name: firstName, last_name: lastName, email: email, password: password, phone: phoneNumber, country_code: countryCode, password_confirmation: password)
        let urlString = APIURL.finalUrl(APIURL.auth.register)
        print(urlString)
        print(requestBody)

        apiManager.postRequest(urlString: urlString, body: requestBody, responseType: RegisterResponse.self)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error: \(error)")
                    self.errorMessage = error.localizedDescription
                case .finished:
                    print("Finished")
                    break
                }
            }) { registerResponse in
                print(registerResponse)
                self.registerResponse = registerResponse
        }.store(in: &cancellables)
    }
}
