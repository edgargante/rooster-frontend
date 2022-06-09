//
//  MainNavigationView.swift
//  olimpiadas
//
//  Created by Edgar Gante on 29/05/22.
//

import SwiftUI

struct MainNavigationView: View {
    @ObservedObject var viewModel = MainNavigationViewModel()
    @Binding var user: User
    
    var body: some View {
        TabView {
            DisciplineView(user: user)
                .tabItem {
                    Image(systemName: "rosette")
                    Text("Disciplinas")
                }
            Text("Entrenadores")
                .tabItem {
                    Image(systemName: "person")
                    Text("Entrenadores")
                }
            Text("Competidores")
                .tabItem {
                    Image(systemName: "person.3")
                    Text("Competidores")
                }
            Text("Jueces")
                .tabItem {
                    Image(systemName: "shareplay")
                    Text("Jueces")
                }
            ProfileView(user: $user)
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Profile")
                }
        }
        .onReceive (
            AppManager.LoggedUser, perform: { viewModel.user = $0 }
        )
    }
}

