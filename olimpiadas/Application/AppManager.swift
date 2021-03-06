//
//  AppManager.swift
//  olimpiadas
//
//  Created by Edgar Gante on 30/05/22.
//

import Foundation
import Combine

struct AppManager {
    static let Authenticated = PassthroughSubject<Bool, Never>()
    static let LoggedUser = PassthroughSubject<User, Never>()

    static func IsAuthenticated() -> Bool {
        return UserDefaults.standard.string(forKey: "token") != nil
    }
    
}
