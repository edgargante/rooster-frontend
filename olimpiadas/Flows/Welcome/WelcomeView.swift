//
//  WelcomeView.swift
//  olimpiadas
//
//  Created by Edgar Gante on 05/05/22.
//

import SwiftUI

struct WelcomeView: View {
    
    @ObservedObject private var userViewModel = SignupViewModel()
    @State var presentAlert = false
    @State private var showLogin = false
    @State private var showSignupView = false
    
    let action: () -> Void = { /* DO SOMETHING */ }
    
    var body: some View {
        NavigationView {
            VStack {
                Image("home-img")
                    .resizable()
                    .scaledToFit()dwedew    
                Text("Olimpiadas")
                    .bold()
                    .font(.system(size: 32))
                Spacer()
                Button (
                    action: {
                        showLogin.toggle()
                    },
                    label: {
                        Text("Iniciar Sesión")
                            .font(.headline)
                            .frame(maxWidth: 300)
                    }
                )
                .tint(.blue)
                .buttonStyle(.bordered)
                .controlSize(.large)
                .sheet(isPresented: $showLogin) {
                    LoginView()
                }
                
                Button (
                    action: {
                        showSignupView.toggle()
                    },
                    label: {
                        Text("Registro")
                            .font(.headline)
                            .frame(maxWidth: 300)
                    }
                )
                .buttonStyle(.bordered)
                .controlSize(.large)
                .sheet(isPresented: $showSignupView) {
                    SignupView()
                }
            }
            .padding()
        }
    }
}
