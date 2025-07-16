//
//  StartupView.swift
//  FitBlinkGym
//
//  Created by Dipang Sheth on 16/07/25.
//

import SwiftUI

struct StartupView: View {
    @State private var path: [ViewRouter] = []
    @AppStorage("token") var token = ""

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Image("launchIcon")
                    .padding()
                Text("Welcome to FitBlink Gym")
                    .customFont(.bold,size: 20)
                Button(action: {
                        if !token.isEmpty {
                            path.append(.register)
                        } else {
                            path.append(.login)
                        }
                    
                }) {
                    Text("Get Started")
                        .customFont(.bold,size: 18)
                        .foregroundColor(.backgroundWhite)
                        .frame(width: 240, height: 50)
                        .background(.primaryPink)
                        .cornerRadius(CornerRedious.ButtonCornerRadius)
                }
                
                .padding(.top, 40)
                .navigationDestination(for: ViewRouter.self) { router in
                    switch router {
                    case .login:
                        LoginView(path: $path)
                    case .register:
                        Registerview(path: $path)
                    case .verfyEmail:
                        LoginView(path: $path)
                    case .dashboard:
                        LoginView(path: $path)
                    }
                    
                }
            }
        }
        
        .navigationBarBackButtonHidden(true)
        

    }
}

#Preview {
    StartupView()
}
