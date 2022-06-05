//
//  SignupView.swift
//  olimpiadas
//
//  Created by Edgar Gante on 05/05/22.
//

import SwiftUI

struct SignupView: View {
    
    @ObservedObject private var userViewModel = SignupViewModel()
    @State var showAlert = false
    @State var responseMessage = ""
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                Section(footer: Text(userViewModel.mailMessage)
                    .foregroundColor(.red)
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .leading)
                ) {
                    TextField("Correo", text: $userViewModel.correo)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                    Rectangle()
                        .frame(height: 1.0, alignment: .bottom)
                        .foregroundColor(Color.gray)
                }
                
                Section(footer: Text(userViewModel.usernameMessage)
                    .foregroundColor(.red)
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .leading)
                ) {
                    TextField("Usuario", text: $userViewModel.username)
                        .autocapitalization(.none)
                    Rectangle()
                        .frame(height: 1.0, alignment: .bottom)
                        .foregroundColor(Color.gray)
                }
                Section(footer: Text(userViewModel.passwordMessage)
                    .foregroundColor(.red)
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .leading)
                ) {
                    SecureField("Contraseña", text: $userViewModel.password)
                    Rectangle()
                        .frame(height: 1.0, alignment: .bottom)
                        .foregroundColor(Color.gray)
                    SecureField("Verifica Contraseña", text: $userViewModel.passwordAgain)
                    Rectangle()
                        .frame(height: 1.0, alignment: .bottom)
                        .foregroundColor(Color.gray)
                }
                Section(footer: Text(userViewModel.codeMessage)
                    .foregroundColor(.red)
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .leading)
                ) {
                    TextField("Código", text: $userViewModel.code)
                        .autocapitalization(.none)
                        .keyboardType(.numberPad)
                    Rectangle()
                        .frame(height: 1.0, alignment: .bottom)
                        .foregroundColor(Color.gray)
                }
                
                Spacer()
                Button(action: {
                    APIClient.signup(
                        id: Int.random(in: 0..<5000),
                        name: userViewModel.username,
                        email: userViewModel.correo,
                        role: Int(userViewModel.code) ?? 5,
                        password: userViewModel.password) { response in
                            switch response {
                            case .success:
                                self.responseMessage = "Exito con registro"
                                presentationMode.wrappedValue.dismiss()
                            case .failure(let error):
                                let nsError = error as NSError
                                    print(nsError.localizedDescription)
                                self.responseMessage = nsError.localizedDescription
                                self.showAlert.toggle()
                            }
                    

                        }
                }
                ) {
                    Text("Registro")
                        .font(.headline)
                        .frame(maxWidth: 300)
                }
                .tint(.blue)
                .buttonStyle(.bordered)
                .controlSize(.large)
                .disabled(!self.userViewModel.isValid)
            }
            .padding()
            .navigationTitle("Registro")
            .alert(isPresented: $showAlert, content: {
                Alert(title: Text(responseMessage))
            })
            
        }
    }
}
