//
//  DisciplineDetailView.swift
//  olimpiadas
//
//  Created by Edgar Gante on 30/05/22.
//

import SwiftUI

struct DisciplineDetailView: View {
    @State var discipline: Discipline
    @State private var showEditView = false

    var body: some View {
        VStack {
            
        }
        .sheet(isPresented: $showEditView) {
            EditDisciplineView(discipline: self.discipline)
        }
        .navigationTitle(discipline.discipline_name)
        .toolbar {
            Button (
                action: {
                    showEditView.toggle()
                },
                label: {
                    Text("Editar")
                        .bold()
                }
            )
        }
    }
}
