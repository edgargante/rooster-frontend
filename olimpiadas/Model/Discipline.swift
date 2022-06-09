//
//  Discipline.swift
//  olimpiadas
//
//  Created by Edgar Gante on 29/05/22.
//

import Foundation

struct Discipline: Codable, Identifiable, Hashable {
    let id: Int
    var discipline_name: String
    let discipline_date: String
}
