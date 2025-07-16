//
//  Registerview.swift
//  FitBlinkGym
//
//  Created by Dipang Sheth on 16/07/25.
//

import SwiftUI

struct Registerview: View {
    
    @StateObject private var viewModel = RegisterViewModel()
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
                    Group {
                        AppTextField(title: "First Name", text: $viewModel.firstName, isSecure: false)
                        AppTextField(title: "Last Name", text: $viewModel.lastName, isSecure: false)
                        AppTextField(title: "Email", text: $viewModel.email, isSecure: false)
                            .keyboardType(.emailAddress)
                        // Password SecureField
                        AppTextField(title: "Password", text: $viewModel.password, isSecure: false)
                        AppTextField(title: "Confirm Password", text: $viewModel.confirmPassword, isSecure: false)
                        HStack {
                            AppTextField(title: "Country Code", text: $viewModel.countryCode, isSecure: false)
                                .frame(width: 120)
                                .padding(.trailing, 10)
                            AppTextField(title: "Phone Number", text: $viewModel.phoneNumber, isSecure: false)
                        }
                        .ignoresSafeArea(.keyboard, edges: .bottom)
                    }
                   
                    Button(action: {
                        viewModel.register()
                    }) {
                        Text("Register")
                            .font(Font.appFont(.bold, size: 18))
                            .foregroundColor(Color.backgroundWhite)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.primaryPink)
                            .cornerRadius(10)
                        
                    }
                    .disabled(!viewModel.isFormValid)
                    .opacity(viewModel.isFormValid ? 1.0 : 0.5)
                    .onChange(of: viewModel.registerResponse) { response in
                        if let response = response, response.status ?? false {
                            path.append(.verfyEmail)
                        }
                    }
                    
                    Text("- Alredy have an account? -")
                        .customFont(.medium, size: 12)
                        .foregroundStyle(.subTitleGray)
                        .padding(.top, 30)
                    
                    HStack(spacing: 5) {
                        Text("Click here to ")
                            .customFont(.regular, size: 16)
                            .foregroundStyle(.titleBlack)
                        
                        Button(action: {
                            path.removeLast()

                        }) {
                            Text("Login")
                                .underline()
                                .font(Font.appFont(.bold, size: 16))
                                .foregroundStyle(AppColors.primaryColor)
                        }
                    }
                }
                .padding(.all, 20)
                .padding(.top, 60)
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .top)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    //Registerview()
}
