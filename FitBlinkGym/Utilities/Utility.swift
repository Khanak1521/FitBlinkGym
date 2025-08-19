//
//  Utility.swift
//  FitBlinkGym
//
//  Created by Dipang Sheth on 16/07/25.
//

import SwiftUI

enum CornerRedious {
    static let ButtonCornerRadius = 12.0
    static let ImageCornerRadius = 10.0
    static let textFieldCornerRadius = 10.0

}

func logDebug(message: String = "") {
    print(message)
}

struct Utility {
    
}


class AuthViewModel: ObservableObject {
    var token: String? {
        UserDefaults.standard.string(forKey: "token")
    }

    func saveToken(_ newToken: String) {
        UserDefaults.standard.set(newToken, forKey: "token")
    }

    func clearToken() {
        UserDefaults.standard.removeObject(forKey: "token")
    }
}

