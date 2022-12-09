//
//  iOS_Productivity_Smart_AppApp.swift
//  iOS Productivity Smart App
//
//  Created by Cold Heat on 12/9/22.
//

import SwiftUI

@main
struct iOS_Productivity_Smart_AppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
