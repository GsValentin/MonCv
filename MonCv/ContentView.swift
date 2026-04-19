//
//  ContentView.swift
//  MonCv
//
//  Created by Valentin on 19/04/2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) private var context
    @Query private var cvs: [CVItem]
    
    @State private var showAdd = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(cvs) { cv in
                    NavigationLink(destination: DetailView(cv: cv)) {
                        VStack(alignment: .leading) {
                            Text(cv.name)
                                .font(.headline)
                            Text(cv.role)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .onDelete(perform: deleteCV)
            }
            .navigationTitle("Mes CV")
            .toolbar {
                Button("Ajouter") {
                    showAdd = true
                }
            }
            .sheet(isPresented: $showAdd) {
                AddCVView()
            }
        }
    }
    
    func deleteCV(at offsets: IndexSet) {
        for index in offsets {
            context.delete(cvs[index])
        }
    }
}

// MARK: - 4. DETAIL D'UN CV

struct DetailView: View {
    var cv: CVItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(cv.name).font(.largeTitle)
            Text(cv.role).font(.title3)
        }
    }
}
struct AddCVView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var context
    
    @State private var name = ""
    @State private var role = ""
    @State private var skills = ""
    @State private var about = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Nom", text: $name)
                TextField("Rôle", text: $role)
                TextField("Compétences", text: $skills)
                TextField("À propos", text: $about)
            }
            .navigationTitle("Nouveau CV")
            .toolbar {
                Button("Sauvegarder") {
                    let newCV = CVItem(name: name, role: role, skills: skills, about: about)
                    context.insert(newCV)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: CVItem.self, inMemory: true)
}
