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
    
    var errorMessage = ""
}

extension LoginViewModel {
    func loginUser() -> Bool {
        if email == "admin@dev.com",
           password == "123456" {
            let token = UUID().uuidString
            UserDefaults.standard.set(token, forKey: "token")
            AppManager.Authenticated.send(true)
            return true
        } else {
            errorMessage = "Credenciales Inválidas"
            return false
        }
    }
}
