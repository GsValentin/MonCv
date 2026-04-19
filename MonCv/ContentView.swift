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
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [Color.blue.opacity(0.15), Color.purple.opacity(0.15)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(cvs) { cv in
                            NavigationLink(destination: DetailView(cv: cv)) {
                                CVCardView(cv: cv)
                            }
                        }
                        .onDelete(perform: deleteCV)
                    }
                    .padding()
                }
            }
            .navigationTitle("📄 Mes CV")
            .toolbar {
                Button {
                    showAdd = true
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.title2)
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

//MARK: - 4. Carte UI STYLE
struct CVCardView: View {
    let cv: CVItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Circle()
                    .fill(Color.blue.opacity(0.2))
                    .frame(width: 40, height: 40)
                    .overlay(
                        Text(String(cv.name.prefix(1)))
                            .font(.headline)
                            .foregroundColor(.blue)
                    )
                
                VStack(alignment: .leading) {
                    Text(cv.name)
                        .font(.headline)
                    Text(cv.role)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            
            Text(cv.skills)
                .font(.caption)
                .foregroundColor(.secondary)
                .lineLimit(1)
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 3)
    }
}

// MARK: - 5. DETAIL D'UN CV

struct DetailView: View {
    var cv: CVItem
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(cv.name)
                        .font(.largeTitle.bold())
                    Text(cv.role)
                        .font(.title3)
                        .foregroundColor(.secondary)
                }
                
                Divider()
                
                SectionCard(title: "💡 Compétences", content: cv.skills)
                SectionCard(title: "👤 À propos", content: cv.about)
                
            }
            .padding()
        }
        .navigationTitle("Détails")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SectionCard: View {
    let title: String
    let content: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
            Text(content)
                .font(.body)
                .foregroundColor(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
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
        NavigationStack {
            Form {
                Section("Infos principales") {
                    TextField("Nom", text: $name)
                    TextField("Métier", text: $role)
                }
                
                Section("Contenu") {
                    TextField("Compétences", text: $skills)
                    TextField("À propos", text: $about)
                }
            }
            .navigationTitle("Nouveau CV")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Sauvegarder") {
                        let newCV = CVItem(name: name, role: role, skills: skills, about: about)
                        context.insert(newCV)
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Annuler") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: CVItem.self, inMemory: true)
}
