//
//  BackgroundView.swift
//  FitBlinkGym
//
//  Created by Dipang Sheth on 15/08/25.
//

import SwiftUI

struct BackgroundView: View {
    
    var body: some View {
        VStack {
            Image("launchIcon")
                .padding()
            Text("Welcome to FitBlink Gym")
                .customFont(.bold,size: 20)
            .padding(.top, 40)
        }
    }
}

#Preview {
    BackgroundView()
}
