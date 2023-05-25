//
//  CoreJSONApp.swift
//  CoreJSON
//
//  Created by YILMAZ ER on 25.05.2023.
//

import SwiftUI

@main
struct CoreJSONApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
