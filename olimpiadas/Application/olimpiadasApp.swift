//
//  olimpiadasApp.swift
//  olimpiadas
//
//  Created by Edgar Gante on 05/05/22.
//

import SwiftUI

@main
struct olimpiadasApp: App {
    @State var isAuthenticated = AppManager.IsAuthenticated()
    @State var user = User(id: 0, name: "", password: "", email: "", role: 55)
    var body: some Scene {
        WindowGroup {
            Group {
                isAuthenticated ? AnyView(MainNavigationView(user: $user))
                : AnyView(WelcomeView())
            }
            .onReceive(
                AppManager.Authenticated, perform: { isAuthenticated = $0 }
            )
            .onReceive (
                AppManager.LoggedUser, perform: { user = $0 }
            )
        }
    }
}

