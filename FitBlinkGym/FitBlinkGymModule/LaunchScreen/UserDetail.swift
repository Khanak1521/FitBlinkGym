//
//  UserDetail.swift
//  FitBlinkGym
//
//  Created by Dipang Sheth on 11/08/25.
//

import SwiftUI
import Combine

struct UserDetail: View {
    var userDetail : UserList
    @State private var path: [ViewRouter] = []

    var body: some View {
        VStack{
            Text(userDetail.name ?? "")
                .customFont(.bold, size: 20)
                .foregroundColor(.black)
                .padding()
            
            Text(userDetail.email ?? "")
                .customFont(.regular, size: 16)
                .foregroundColor(.gray)
                .padding()
            
            Button {
                path.append(.customWebView)
            } label: {
                Text("Click here to open Webview")
                    .customFont(.medium, size: 24)
                    .foregroundStyle(.primaryPink)
            }

        }
        .navigationDestination(for: ViewRouter.self) { router in
            if router == .customWebView {
                CustomWebView()
            }
        }
    }
}

#Preview {
//    let userDetail : UserList = .init(from:  )
//    UserDetail(userDetail: userDetail)
}
