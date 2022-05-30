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
                isAuthenticated ? AnyView(MainNavigationView(user: User(
                    userId: "1",
                    firstName: "Edgar",
                    lastName: "Gante",
                    email: "admin@gmail.com",
                    role: "0")
                ))
                : AnyView(WelcomeView())
            }
            .onReceive(AppManager.Authenticated, perform: {
                isAuthenticated = $0
            })
        }
    }
}
