//
//  Untitled.swift
//  FitBlinkGym
//
//  Created by Dipang Sheth on 18/07/25.
//

import Foundation

struct AuthManager {
    
    static func fetch<T>(_ key: String) -> T? {
        return UserDefaults.standard.object(forKey: key) as? T
    }

    static func save(_ key : String, value : Any ) {
        UserDefaults.standard.set(value, forKey: key)
    }

    static func clear(_ key : String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
