//
//  HomeView.swift
//  FitBlinkGym
//
//  Created by Dipang Sheth on 17/07/25.
//

import SwiftUI

struct HomeView: View {
    
    @Binding var path: [ViewRouter]
    @StateObject var viewModel = GymViewModel()
    
    var body: some View {

        List(viewModel.userList, id: \.self) { user in
            NavigationLink(value: ViewRouter.userDetail(user)) {
                HomeListCell(userList: user)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
            }
        }
        
        .listStyle(.plain)
        .background(AppColors.subtitleColor.opacity(0.1))
        .navigationTitle("Users")
        .task {
            viewModel.fetchUserList()
        }
//        .onAppear {
//            if viewModel.userList.isEmpty {
//            }
//        }
    }
}

#Preview {
    HomeView(path: .constant([]))
}
