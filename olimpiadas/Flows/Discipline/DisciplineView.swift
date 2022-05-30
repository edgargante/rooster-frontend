//
//  DisciplineView.swift
//  olimpiadas
//
//  Created by Edgar Gante on 29/05/22.
//

import SwiftUI

struct DisciplineView: View {
    @State var user: User
    @State private var showDisciplineSheet = false
    @State var disciplines: [Discipline] = [
        Discipline(id: "0", name: "Natación"),
        Discipline(id: "1", name: "Clavados"),
        
    ]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(disciplines) { discipline in
                    NavigationLink {
                        DisciplineDetailView(discipline: discipline)
                    } label: {
                        Text(discipline.name)
                        
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
                    AddDisciplineView()
                }
            }
        }
    }
}
