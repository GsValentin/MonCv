//
//  ContentView.swift
//  MonCv
//
//  Created by Valentin on 19/04/2026.
//

import SwiftUI
import SwiftData

// MARK: - TAB BAR

struct RootTabView: View {
    var body: some View {
        TabView {

            CVHomeView()
                .tabItem {
                    Label("CV", systemImage: "person.text.rectangle")
                }

            SocialView()
                .tabItem {
                    Label("Réseaux", systemImage: "link")
                }

            PersonalInfoView()
                .tabItem {
                    Label("Infos", systemImage: "person.crop.circle")
                }
        }
    }
}


struct CVHomeView: View {

    @Query var experiences: [ExperienceItem]
    @Query var educations: [EducationItem]
    @Query var skills: [SkillItem]

    @Environment(\.modelContext) private var context

    @State private var showAddExp = false
    @State private var showAddEdu = false
    @State private var showAddSkill = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 25) {

                    SectionBlock(title: "💼 Expériences") {
                        ForEach(experiences) { exp in
                            VStack(alignment: .leading) {
                                Text(exp.title).bold()
                                Text(exp.company).foregroundColor(.secondary)
                                Text(exp.details).font(.caption)
                            }
                        }

                        Button("+ Ajouter") { showAddExp = true }
                    }

                    SectionBlock(title: "🎓 Formations") {
                        ForEach(educations) { edu in
                            VStack(alignment: .leading) {
                                Text(edu.school).bold()
                                Text(edu.diploma)
                                Text(edu.year).font(.caption)
                            }
                        }

                        Button("+ Ajouter") { showAddEdu = true }
                    }

                    SectionBlock(title: "🧠 Compétences") {
                        ForEach(skills) { skill in
                            Text("• \(skill.name)")
                        }

                        Button("+ Ajouter") { showAddSkill = true }
                    }
                }
                .padding()
            }
            .navigationTitle("Mon CV")
        }
        .sheet(isPresented: $showAddExp) { AddExperienceView() }
        .sheet(isPresented: $showAddEdu) { AddEducationView() }
        .sheet(isPresented: $showAddSkill) { AddSkillView() }
    }
}

struct SectionBlock<Content: View>: View {
    let title: String
    let content: Content

    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.title3.bold())

            content
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
}

struct SocialView: View {

    @Query var links: [SocialLink]
    @Environment(\.modelContext) private var context
    @State private var showAdd = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(links) { link in
                    VStack(alignment: .leading) {
                        Text(link.platform).bold()
                        Text(link.value).foregroundColor(.blue)
                    }
                }
            }
            .navigationTitle("Réseaux")
            .toolbar {
                Button("Ajouter") { showAdd = true }
            }
        }
        .sheet(isPresented: $showAdd) { AddSocialView() }
    }
}

struct PersonalInfoView: View {

    @Query var infos: [PersonalInfoItem]
    @State private var showAdd = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(infos) { info in
                    HStack {
                        Text(info.type)
                        Spacer()
                        Text(info.value)
                    }
                }
            }
            .navigationTitle("Infos perso")
            .toolbar {
                Button("Ajouter") { showAdd = true }
            }
        }
        .sheet(isPresented: $showAdd) { AddPersonalInfoView() }
    }
}

struct AddExperienceView: View {

    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context

    @State var title = ""
    @State var company = ""
    @State var details = ""

    var body: some View {
        Form {
            TextField("Titre", text: $title)
            TextField("Entreprise", text: $company)
            TextField("Détails", text: $details)

            Button("Ajouter") {
                context.insert(ExperienceItem(title: title, company: company, details: details))
                dismiss()
            }
        }
    }
}

struct AddEducationView: View {

    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context

    @State var school = ""
    @State var diploma = ""
    @State var year = ""

    var body: some View {
        Form {
            TextField("École", text: $school)
            TextField("Diplôme", text: $diploma)
            TextField("Année", text: $year)

            Button("Ajouter") {
                context.insert(EducationItem(school: school, diploma: diploma, year: year))
                dismiss()
            }
        }
    }
}

struct AddSkillView: View {

    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context

    @State var name = ""

    var body: some View {
        Form {
            TextField("Compétence", text: $name)

            Button("Ajouter") {
                context.insert(SkillItem(name: name))
                dismiss()
            }
        }
    }
}

struct AddSocialView: View {

    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context

    @State var platform = ""
    @State var value = ""

    var body: some View {
        Form {
            TextField("Plateforme", text: $platform)
            TextField("Lien", text: $value)

            Button("Ajouter") {
                context.insert(SocialLink(platform: platform, value: value))
                dismiss()
            }
        }
    }
}

struct AddPersonalInfoView: View {

    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context

    @State var type = ""
    @State var value = ""

    var body: some View {
        Form {
            TextField("Type", text: $type)
            TextField("Valeur", text: $value)

            Button("Ajouter") {
                context.insert(PersonalInfoItem(type: type, value: value))
                dismiss()
            }
        }
    }
}

#Preview {
    RootTabView()
        .modelContainer(for: [
            ExperienceItem.self,
            EducationItem.self,
            SkillItem.self,
            SocialLink.self,
            PersonalInfoItem.self
        ], inMemory: true)
}
