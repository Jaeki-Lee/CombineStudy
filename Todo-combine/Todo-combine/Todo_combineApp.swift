//
//  Todo_combineApp.swift
//  Todo-combine
//
//  Created by JaeKi on 10/21/24.
//

import SwiftUI

@main
struct Todo_combineApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
