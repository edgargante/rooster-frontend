//
//  EditDisciplineView.swift
//  olimpiadas
//
//  Created by Edgar Gante on 31/05/22.
//

import SwiftUI

struct EditDisciplineView: View {
    var discipline: Discipline
    @Environment(\.presentationMode) var presentationMode
    @State var newName = ""
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                VStack {
                    TextField(discipline.discipline_name, text: $newName)
                    Rectangle()
                        .frame(height: 1.0, alignment: .bottom)
                        .foregroundColor(Color.gray)
                    Text("Nombre")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                Spacer()
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Label("Eliminar", image: "trash")
                        .font(.headline)
                        .frame(maxWidth: 300)
                }
                .tint(.red)
                .buttonStyle(.bordered)
                .controlSize(.large)
            }
            .toolbar {
                Button (
                    action: {
                        presentationMode.wrappedValue.dismiss()
                    },
                    label: {
                        Text("Guardar")
                            .bold()
                    }
                )
            }
            .padding()
            .navigationTitle("Editar")
        }
    }
}
