//
//  Item.swift
//  MonCv
//
//  Created by Valentin on 19/04/2026.
//

import Foundation
import SwiftData

@Model
class ExperienceItem {
    var id: UUID
    var title: String
    var company: String
    var details: String
    
    init(title: String, company: String, details: String) {
        self.id = UUID()
        self.title = title
        self.company = company
        self.details = details
    }
}

@Model
class EducationItem {
    var id: UUID
    var school: String
    var diploma: String
    var year: String
    
    init(school: String, diploma: String, year: String) {
        self.id = UUID()
        self.school = school
        self.diploma = diploma
        self.year = year
    }
}

@Model
class SkillItem {
    var id: UUID
    var name: String
    
    init(name: String) {
        self.id = UUID()
        self.name = name
    }
}

@Model
class SocialLink {
    var id: UUID
    var platform: String
    var value: String
    
    init(platform: String, value: String) {
        self.id = UUID()
        self.platform = platform
        self.value = value
    }
}

@Model
class PersonalInfoItem {
    var id: UUID
    var type: String
    var value: String

    init(type: String, value: String) {
        self.id = UUID()
        self.type = type
        self.value = value
    }
}
