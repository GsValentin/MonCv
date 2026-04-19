//
//  MonCvApp.swift
//  MonCv
//
//  Created by Valentin on 19/04/2026.
//

import SwiftUI
import SwiftData

@main
struct CVApp: App {
    var body: some Scene {
        WindowGroup {
            RootTabView()
        }
        .modelContainer(for: [
            ExperienceItem.self,
            EducationItem.self,
            SkillItem.self,
            SocialLink.self,
            PersonalInfoItem.self
        ])
    }
}
