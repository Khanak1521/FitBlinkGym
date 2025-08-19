//
//  LoginModel.swift
//  FitBlinkGym
//
//  Created by Dipang Sheth on 16/07/25.
//

import Foundation
import Combine

class GymViewModel : ObservableObject {
    
    @Published var cancellables: Set<AnyCancellable> = []
    private let apiManager: APIManagerProtocol
    let GymListResponse = PassthroughSubject<[UserList], Never>()

    @Published var userList : [UserList] = []
    @Published var errorMessage: String?
    
    init(apimanager: APIManagerProtocol = APIManager()) {
        self.apiManager = apimanager
        
        GymListResponse.sink { [weak self] gymList in
            self?.userList = gymList
        }.store(in: &cancellables)
    }
    
    func fetchUserList() {
        let urlString = "https://jsonplaceholder.typicode.com/users" //APIURL.finalUrl(APIURL.gym.gym)
        apiManager.fetchRequest(urlString: urlString,responseType: UserList.self)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                case .finished :
                    print("finished")
                }
            }) { gymList in
                print(gymList)
                self.GymListResponse.send(gymList)
        }.store(in: &cancellables)
    }
    
}
