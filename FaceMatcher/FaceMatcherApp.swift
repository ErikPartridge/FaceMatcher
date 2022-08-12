//
//  FaceMatcherApp.swift
//  FaceMatcher
//
//  Created by Erik Partridge on 8/12/22.
//

import SwiftUI

@main
struct FaceMatcherApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
