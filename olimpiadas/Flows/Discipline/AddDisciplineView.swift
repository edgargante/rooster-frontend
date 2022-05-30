//
//  AddDisciplineView.swift
//  olimpiadas
//
//  Created by Edgar Gante on 29/05/22.
//

import SwiftUI

struct AddDisciplineView: View {
    @Environment(\.dismiss) var dismiss
    @State var inputText: String = ""

    var body: some View {
        NavigationView {
            VStack {
                TextField("Nombre de Disciplina", text: $inputText)
                Rectangle()
                    .frame(height: 1.0, alignment: .bottom)
                    .foregroundColor(Color.blue)
                Spacer()
                Button(action: {}) {
                    Text("Agregar")
                        .font(.headline)
                        .frame(maxWidth: 300)
                }
                .tint(.blue)
                .buttonStyle(.bordered)
                .controlSize(.large)
            }
            .padding()
            .navigationTitle("Agregar Disciplina")
        }
        
    }
}
