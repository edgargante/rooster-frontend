//
//  DisciplineView.swift
//  olimpiadas
//
//  Created by Edgar Gante on 29/05/22.
//

import SwiftUI

struct DisciplineView: View {
    @State var user: User
    
    @ObservedObject private var viewModel = DisciplineViewModel()
    @State private var showDisciplineSheet = false

    
    var body: some View {
        NavigationView {
            List {
                ForEach($viewModel.disciplines, id: \.self) { discipline in
                    NavigationLink {
                        DisciplineDetailView(discipline: discipline.wrappedValue)
                    } label: {
                        Text(discipline.discipline_name.wrappedValue)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Disciplinas")
            .toolbar {
                Button (
                    action: {
                        showDisciplineSheet.toggle()
                    },
                    label: {
                        Text("Agregar")
                            .bold()
                    }
                )
                .sheet(isPresented: $showDisciplineSheet) {
                    AddDisciplineView(disciplines: viewModel.disciplines)
                }
            }
        }
    }
}
