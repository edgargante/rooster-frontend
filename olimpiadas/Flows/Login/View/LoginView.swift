//
//  LoginView.swift
//  olimpiadas
//
//  Created by Edgar Gante on 29/05/22.
//

import SwiftUI

struct LoginView: View {
    enum Field: Hashable {
        case usernameField
        case passwordField
    }
    @FocusState private var focusedField: Field?
    @ObservedObject var viewModel = LoginViewModel()
    @State var showAlert = false

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                    TextField("Email", text: $viewModel.email)
                        .focused($focusedField, equals: .usernameField)
                    Rectangle()
                        .frame(height: 1.0, alignment: .bottom)
                        .foregroundColor(Color.gray)
                    SecureField("Password", text: $viewModel.password)
                        .focused($focusedField, equals: .passwordField)
                    Rectangle()
                        .frame(height: 1.0, alignment: .bottom)
                        .foregroundColor(Color.gray)
                Spacer()
                Button(action: {
                    showAlert = !viewModel.loginUser()

                }) {
                    Text("Ingresar")
                        .font(.headline)
                        .frame(maxWidth: 300)
                }
                .tint(.blue)
                .buttonStyle(.bordered)
                .controlSize(.large)
            }
            .padding()
            .navigationTitle("Iniciar Sesión")
            .alert(isPresented: $showAlert, content: {
                Alert(title: Text(viewModel.errorMessage))
            })
        }
  
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
