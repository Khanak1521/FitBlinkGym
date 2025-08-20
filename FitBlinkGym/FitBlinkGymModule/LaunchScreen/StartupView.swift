//
//  StartupView.swift
//  FitBlinkGym
//
//  Created by Dipang Sheth on 16/07/25.
//

import SwiftUI

struct StartupView: View {
    @State private var path: [ViewRouter] = []
    @Environment(\.scenePhase) var scenePhase

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Image("launchIcon")
                    .padding()
                Text("Welcome Here")
                    .customFont(.bold,size: 20)
                Button(action: {
                    if let token: String = AuthManager.fetch("token"), !token.isEmpty {
                        path.append(.dashboard)
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
                .onChange(of: scenePhase) { newPhase in
                    switch newPhase {
                    case .active:
                        print("Ative")
                    case .inactive:
                        print("InActive")
                    case .background:
                        print("Background")
                    default:
                        break
                    }
                    
                }
                .navigationDestination(for: ViewRouter.self) { router in
                    
                    switch router {
                    case .login:
                        LoginView(path: $path)
                        
                    case .register:
                        Registerview(path: $path)
                        
                    case .dashboard:
                        HomeView(path: $path)
                        
                    case .userDetail(let user):
                        UserDetail(userDetail: user)
                        
                    case .verfyEmail:
                        HomeView(path: $path)
                        
                    case .customWebView:
                        CustomWebView()
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
