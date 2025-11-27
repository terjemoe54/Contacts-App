//
//  Contacts_AppApp.swift
//  Contacts App
//
//  Created by Terje Moe on 24/03/2025.
//   Etter mye styr fra Tuen prøver vi igjen
// Denne bruker Swift Data
import SwiftUI

@main
struct Contacts_AppApp: App {
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
                .modelContainer(for: [Contact.self])
        }
    }
    init() {
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}
