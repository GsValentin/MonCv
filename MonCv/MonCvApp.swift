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
            ContentView()
        }
        // Ici on active SwiftData (la mémoire de l'app)
        .modelContainer(for: CVItem.self)
    }
}
