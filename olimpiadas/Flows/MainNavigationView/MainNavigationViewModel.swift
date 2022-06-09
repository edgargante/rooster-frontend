//
//  MainNavigationViewModel.swift
//  olimpiadas
//
//  Created by Edgar Gante on 05/06/22.
//

import Foundation

class MainNavigationViewModel: ObservableObject {

    @Published var user = User(id: 0, name: "", password: "", email: "", role: 1)

    
    func getUser(userId: Int) {
        APIClient.getUser(id: userId) { response in
            switch response {
            case .success(let user):
                self.user = user
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
}
