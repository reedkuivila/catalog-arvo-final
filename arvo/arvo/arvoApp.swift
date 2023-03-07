//
//  arvoApp.swift
//  arvo
//
//  Created by reed kuivila on 3/7/23.
//

import SwiftUI
import Firebase

@main
struct arvoApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self)  var appDelegate
    
    var body: some Scene {
        WindowGroup {
            let viewModel = AppViewModel()
            ContentView()
                .environmentObject(viewModel)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
                     [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        
        return true
    }
}
    
