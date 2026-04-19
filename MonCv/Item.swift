//
//  Item.swift
//  MonCv
//
//  Created by Valentin on 19/04/2026.
//

import Foundation
import SwiftData

@Model
class CVItem {
    var id: UUID
    var name: String
    var role: String
    var skills: String
    var about: String
    
    init(name: String, role: String, skills: String, about: String) {
        self.id = UUID()
        self.name = name
        self.role = role
        self.skills = skills
        self.about = about
    }
}
