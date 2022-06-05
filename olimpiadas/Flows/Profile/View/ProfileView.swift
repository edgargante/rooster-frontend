//
//  ProfileView.swift
//  olimpiadas
//
//  Created by Edgar Gante on 29/05/22.
//

import SwiftUI

struct ProfileView: View {
    @State var user: User
    @ObservedObject var viewModel = ProfileViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                Spacer()
                VStack {
                    Image(systemName: "person")
                        .resizable()
                        .frame(width: 32, height: 32)
                    Text(user.name)
                        .bold()
                        .font(.title)
                    Text(user.email)
                        .font(.body)
                        .foregroundColor(.secondary)
                    switch user.role {
                    case 0:
                        Text("Administrador")
                            .multilineTextAlignment(.center)
                            .padding()
                    default:
                        Text("None")
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                }
                
                Button (
                    action: {
                        viewModel.logoutUser()
                    },
                    label: {
                        Label("Cerrar Sesión", systemImage: "")
                    })
                Spacer()
                Spacer()
            }
            .navigationTitle("Perfil")

        }
    }
}

