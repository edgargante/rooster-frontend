//
//  DisciplineDetailView.swift
//  olimpiadas
//
//  Created by Edgar Gante on 30/05/22.
//

import SwiftUI

struct DisciplineDetailView: View {
    @State var discipline: Discipline
    var body: some View {
        VStack {
            
        }
        .navigationTitle(discipline.name)
        .toolbar {
            Button (
                action: { },
                label: {
                    Text("Editar")
                        .bold()
                }
            )
        }
    }
}
