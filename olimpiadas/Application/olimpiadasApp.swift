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
    var body: some Scene {
        WindowGroup {
            Group {
                isAuthenticated ? AnyView(MainNavigationView(user: User(id: 55, name: "", password: "", email: "", role: 0)
                ))
                : AnyView(WelcomeView())
            }
            .onReceive(AppManager.Authenticated, perform: {
                isAuthenticated = $0
            })
        }
    }
}
