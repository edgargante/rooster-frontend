//
//  MainNavigationView.swift
//  olimpiadas
//
//  Created by Edgar Gante on 29/05/22.
//

import SwiftUI

struct MainNavigationView: View {
    @State var user: User
    var body: some View {
            TabView {
                DisciplineView(user: user)
                    .tabItem {
                        Image(systemName: "rosette")
                        Text("Disciplinas")
                    }

                ProfileView(user: user)
                    .tabItem {
                        Image(systemName: "person.crop.circle")
                        Text("Profile")
                    }
            
        }
    }
}
