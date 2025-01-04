//
//  ExperienceshopApp.swift
//  Experienceshop
//
//  Created by Bijan Saud on 1/3/25.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct ExperienceshopApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var authManager = AuthManager() // Shared instance of AuthManager

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authManager) // Provide the authManager to the entire app
        }
    }
}
