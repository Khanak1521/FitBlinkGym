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

    var body: some View {
        Group {
            if isSecure {
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
    }
}

#Preview {
    //AppTextField(title: "", text: Binding<String>)
}
