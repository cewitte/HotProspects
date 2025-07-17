//
//  HotProspectsApp.swift
//  HotProspects
//
//  Created by Carlos Eduardo Witte on 17/06/25.
//

import SwiftUI
import SwiftData

@main
struct HotProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Prospect.self)
    }
}
