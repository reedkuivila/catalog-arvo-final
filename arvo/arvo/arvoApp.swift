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
    
    @StateObject var observedResults = ObservedResults()
    @StateObject var catalog = Catalog()
    @StateObject var bookmarks = Bookmarks()
    @StateObject var displayMsg = DisplayMessage()
    @StateObject var opened = TrackOpenings()
    @StateObject var userInfo = UserAccount()
    @StateObject var splashScreenState = SplashScreenStateManager()

    
    init(){
        let appearance = UINavigationBarAppearance()
                    appearance.configureWithOpaqueBackground()
                    appearance.shadowColor = .clear    //removing navigationbar 1 px bottom border.
                    appearance.backgroundColor = #colorLiteral(red: 0.1924162178, green: 0.1908109435, blue: 0.1929768041, alpha: 1)
                    appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
                    appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
                    UINavigationBar.appearance().standardAppearance = appearance
                    UINavigationBar.appearance().scrollEdgeAppearance = appearance
                    UITableView.appearance().backgroundColor = .clear
        UITabBar.appearance().barTintColor = #colorLiteral(red: 0.1924162178, green: 0.1908109435, blue: 0.1929768041, alpha: 1)
    }
    
    var body: some Scene {
        WindowGroup {
            let viewModel = AppViewModel()
            ContentView()
                .environmentObject(observedResults)
                .environmentObject(catalog)
                .environmentObject(bookmarks)
                .environmentObject(viewModel)
                .environmentObject(displayMsg)
                .environmentObject(opened)
                .environmentObject(userInfo)
            ZStack {
                   ContentView()
                   
                   if splashScreenState.state != .finished {
                       SplashScreenView()
                   }
               }.environmentObject(splashScreenState)
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
    
