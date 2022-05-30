//
//  ProfileViewModel.swift
//  olimpiadas
//
//  Created by Edgar Gante on 30/05/22.
//

import Foundation
import Combine

class ProfileViewModel: ObservableObject {
    func logoutUser() {
        UserDefaults.standard.removeObject(forKey: "token")
        AppManager.Authenticated.send(false)
    }
}
