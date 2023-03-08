//
//  DateFirestoreApp.swift
//  arvo
//
//  Created by reed kuivila on 3/8/23.
//

import SwiftUI
import Firebase
@main
struct DateFirestoreApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
          JoinDate()
        }
    }
}
