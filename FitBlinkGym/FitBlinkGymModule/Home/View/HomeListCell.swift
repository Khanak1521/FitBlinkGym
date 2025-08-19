//
//  HomeListCell.swift
//  FitBlinkGym
//
//  Created by Dipang Sheth on 18/07/25.
//

import SwiftUI

struct HomeListCell: View {
    
    var userList : UserList?

    var body: some View {
        HStack(alignment: .top, spacing: 5) {
            Image("users")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .padding(.top, 10)

            VStack(alignment: .leading, spacing: 5) {
                Text(userList?.name?.capitalized ?? "")
                    .customFont(.bold, size: 20)
                    .foregroundStyle(.titleBlack)

                Text(userList?.email ?? "")
                    .customFont(.medium, size: 16)
                    .foregroundStyle(.subTitleGray)

                Text(userList?.phone ?? "")
                    .customFont(.medium, size: 16)
                    .foregroundStyle(.primaryPink)

                Text(userList?.address?.fullAddress ?? "")
                    .customFont(.regular, size: 16)
                    .foregroundStyle(.primaryPink)
            }
            Spacer()
        }
        .padding(10)
        .background(Color.white)
        .cornerRadius(CornerRedious.textFieldCornerRadius)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}

#Preview {
    HomeListCell()
}
