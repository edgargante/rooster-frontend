//
//  DisciplineViewModel.swift
//  olimpiadas
//
//  Created by Edgar Gante on 08/06/22.
//

import SwiftUI

class DisciplineViewModel: ObservableObject {

    @Published var disciplines: [Discipline] = []

    init() {
        getDisciplines()
    }
    
    func getDisciplines() {
        APIClient.getDisciplines { response in
            switch response {
            case .success(let disciplines):
                self.disciplines = disciplines
            case .failure(let error):
                print(error)
            }
        }
    }
}
