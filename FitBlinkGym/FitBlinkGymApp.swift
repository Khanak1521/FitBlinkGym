//
//  FitBlinkGymApp.swift
//  FitBlinkGym
//
//  Created by Dipang Sheth on 16/07/25.
//

import SwiftUI

@main
struct FitBlinkGymApp: App {
    
    @Environment(\.scenePhase) var scenePhase
    
    @State private var isBackground: Bool = false
    
    var body: some Scene {
        WindowGroup {
            StartupView()
            
            ZStack {
                if isBackground {
                    BackgroundView()
                        .zIndex(2)
                }
            }
            
            .onChange(of: scenePhase) { newValue in
                
                switch newValue {
                case .active:
                    isBackground = false
                    break
                case .inactive:
                    break
                case .background:
                    isBackground = true
                    break
                default:
                    break
                }
            }
        }
    }
}
