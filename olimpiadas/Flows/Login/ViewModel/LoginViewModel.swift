//
//  LoginViewModel.swift
//  olimpiadas
//
//  Created by Edgar Gante on 29/05/22.
//

import SwiftUI
import Combine

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isLogged = false

    var errorMessage = ""
}

extension LoginViewModel {
    func loginUser(email: String, pass: String) {
        APIClient.login(
            email: email,
            password: pass) { result in
                switch result {
                case .success(let user):
                    let token = UUID().uuidString
                    UserDefaults.standard.set(token, forKey: "token")
                    AppManager.LoggedUser.send(user)
                    AppManager.Authenticated.send(true)
                    self.isLogged.toggle()
                case .failure(let error):
                    print(error)
                }
            }
    }
}

