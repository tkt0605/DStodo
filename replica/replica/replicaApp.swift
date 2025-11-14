//
//  replicaApp.swift
//  replica
//
//  Created by 駒田隆人 on 2025/11/14.
//

import SwiftUI
import CoreData

@main
struct replicaApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
