//
//  SlidingNumbersApp.swift
//  SlidingNumbers
//
//  Created by fredrik sundström on 2023-04-01.
//


// https://developer.apple.com/forums/thread/724993

import SwiftUI
import Firebase


class AppDelegate: NSObject, UIApplicationDelegate {
    
    /*func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }*/
    func application(_ application: UIApplication,
                     shouldAllowExtensionPointIdentifier extensionPointIdentifier: UIApplication.ExtensionPointIdentifier) -> Bool {
        return extensionPointIdentifier != UIApplication.ExtensionPointIdentifier.keyboard
    }
}

@main
struct SlidingNumbersApp: App{
    @Environment(\.scenePhase) private var phase
    //@UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var firebaseAuth = FirebaseAuth()
    
    init(){
        FirebaseApp.configure()
    }
    
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
