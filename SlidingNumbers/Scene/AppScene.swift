//
//  AppScene.swift
//  SlidingNumbers
//
//  Created by fredrik sundström on 2023-04-15.
//

import SwiftUI
struct AppScene: Scene {
    @Environment(\.scenePhase) private var phase
    @StateObject var firebaseAuth = FirebaseAuth()
  
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(firebaseAuth)
                
        }
        .onChange(of: phase) { newPhase in
            switch newPhase {
            case .active:
                printAny("Active")
            case .inactive:
                printAny("InActive")
            case .background:
                printAny("Background")
            @unknown default:
                printAny("Unknown Future Options")
            }
        }
    }
}
