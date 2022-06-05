//
//  User.swift
//  olimpiadas
//
//  Created by Edgar Gante on 29/05/22.
//

import Foundation

struct User: Codable {
    let id: Int
    let name: String
    let password: String
    let email: String
    let role: Int
}
