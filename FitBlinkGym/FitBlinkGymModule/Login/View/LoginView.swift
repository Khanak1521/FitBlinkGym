//
//  LoginView.swift
//  FitBlinkGym
//
//  Created by Dipang Sheth on 16/07/25.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject private var viewModel = LoginViewModel()
    @Binding var path: [ViewRouter]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 20) {
                    // Image
                    Image("launchIcon")
                        .resizable()
                        .frame(width: 125, height: 100)
                        .padding(.top, -80)
                    
                    // Label
                    Text("Welcome To SwiftUI")
                        .customFont(.bold, size: 30)
                        .foregroundStyle(.titleBlack)
                    
                    // Email TextField
                    AppTextField(title: "Email", text: $viewModel.email, isSecure: false)
                            .keyboardType(.emailAddress)
                    
                    // Password SecureField
                    AppTextField(title: "Password", text: $viewModel.password, isSecure: true)
                            .keyboardType(.default)
                                        
                    Button(action: {
                        viewModel.login()
                    }) {
                        Text("Login")
                            .font(Font.appFont(.bold, size: 18))
                            .foregroundColor(Color.backgroundWhite)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.primaryPink)
                            .cornerRadius(10)
                    }
                    .disabled(!viewModel.isFormValid)
                    .opacity(viewModel.isFormValid ? 1.0 : 0.5)
                    .onChange(of: viewModel.loginResponse) { response in
                        if let response = response, response.status ?? false, let token = response.accessToken {
                            @AppStorage("token") var token = token
                            path.append(.register)
                        }
                    }
                    
                    Text("- OR Continue with -")
                        .customFont(.medium, size: 12)
                        .foregroundStyle(.subTitleGray)
                        .padding(.top, 30)
                    
                    HStack(spacing: 5) {
                        Text("Create An Account")
                            .customFont(.regular, size: 16)
                            .foregroundStyle(.titleBlack)
                        
                        Button(action: {
                            path.append(.register)
                        }) {
                            Text("Register")
                                .underline()
                                .font(Font.appFont(.bold, size: 16))
                                .foregroundStyle(AppColors.primaryColor)
                        }
                    }
                }
                .padding(.all, 30)
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    LoginView(path: .constant([]))
}
