//
//  SignupView.swift
//  olimpiadas
//
//  Created by Edgar Gante on 05/05/22.
//

import SwiftUI

struct SignupView: View {
    
    @ObservedObject private var userViewModel = SignupViewModel()
    @State var presentAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        TextField("Correo", text: $userViewModel.correo)
                            .autocapitalization(.none)
                            .keyboardType(.emailAddress)
                    }
                    Section(footer: Text(userViewModel.usernameMessage).foregroundColor(.red)) {
                        TextField("Usuario", text: $userViewModel.username)
                            .autocapitalization(.none)
                    }
                    Section(footer: Text(userViewModel.passwordMessage).foregroundColor(.red)) {
                        SecureField("Contraseña", text: $userViewModel.password)
                        SecureField("Verifica Contraseña", text: $userViewModel.passwordAgain)
                    }
                    Section(footer: Text(userViewModel.codeMessage).foregroundColor(.red)) {
                        TextField("Código", text: $userViewModel.code)
                            .autocapitalization(.none)
                            .keyboardType(.numberPad)
                    }
                }
                Button(action: { self.signUp() }) {
                    Text("Registro")
                        .bold()
                        .padding()
                    
                }.disabled(!self.userViewModel.isValid)
                
            }
            .navigationTitle("Registro")
        }
    }
    
    func signUp() {
        self.presentAlert = true
    }
}

struct WelcomeTestView: View {
    var body: some View {
        Text("Hola")
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
