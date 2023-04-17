//
//  To_Do_ListApp.swift
//  To Do List
//
//  Created by Aaron Reinke on 4/17/23.
//

import SwiftUI

@main
struct To_Do_ListApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)

        }
    }
}
