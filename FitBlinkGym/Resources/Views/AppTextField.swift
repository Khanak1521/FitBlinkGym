//
//  AppTextField.swift
//  FitBlinkGym
//
//  Created by Dipang Sheth on 16/07/25.
//

import SwiftUI

struct AppTextField: View {
    
    let title: String
    @Binding var text: String
    var isSecure: Bool = false
    @State private var isPasswordVisible = false

    var body: some View {
        ZStack(alignment: .trailing) {
            Group {
                if isSecure && !isPasswordVisible {
                    SecureField(title, text: $text)
                } else {
                    TextField(title, text: $text)
                }
            }
            .padding()
            .font(Font.appFont(.regular, size: 16))
            .background(AppColors.subtitleColor.opacity(0.1))
            .cornerRadius(CornerRedious.textFieldCornerRadius)
            .scrollDismissesKeyboard(.interactively)
            
            if isSecure {
                Button(action: {
                    isPasswordVisible.toggle()
                }) {
                    Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                        .foregroundColor(.gray)
                }
                .padding(.trailing, 10)
            }
        }
    }
}

#Preview {
    //AppTextField(title: "", text: Binding<String>)
}
