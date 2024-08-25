//
//  medat_statsApp.swift
//  medat-stats
//
//  Created by Jonas Becker on 13.08.24.
//

import SwiftUI
import SwiftData

@main
struct medat_statsApp: App {
//    var sharedModelContainer: ModelContainer = {
//        let schema = Schema([
//            TestResult.self,
//        ])
//        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
//
//        do {
//            return try ModelContainer(for: schema, configurations: [modelConfiguration])
//        } catch {
//            fatalError("Could not create ModelContainer: \(error)")
//        }
//    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [TestResult.self])
//        .modelContainer(sharedModelContainer)
    }
}
