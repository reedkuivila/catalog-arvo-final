//
//  ContentView.swift
//  arvo
//
//  Created by reed kuivila on 3/7/23.
//

import SwiftUI
//import FirebaseAuth

class AppViewModel: ObservableObject {
    let auth = Auth.auth()
    @Published public var signedIn = false

    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    func emailSignIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            // successfully signed in
            print("successfully signed in")
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    }
    
    func emailSignUp(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            // successfully signed up
            print("successful sign up")
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    }
    
    func signOut() {
        try? auth.signOut()

        self.signedIn = false
    }
}

struct ContentView: View {
    @EnvironmentObject public var viewModel: AppViewModel
    @EnvironmentObject var observedResults: ObservedResults
    @EnvironmentObject var catalog: Catalog
    @EnvironmentObject var bookmarks: Bookmarks
    @EnvironmentObject var displayMsg: DisplayMessage
    @EnvironmentObject var opened: TrackOpenings
    @Environment(\.scenePhase)var scenePhase
    
    var showAlert: Bool {
        if opened.openedCount == 3{
            return true
        } else{
            return false
        }
    }
    @EnvironmentObject var userInfo: UserAccount
    
    var body: some View {
        
        ZStack{
            Color.blue
                .ignoresSafeArea()
            Text("splash")
                .foregroundColor(.white)
            if self.viewModel.isSignedIn {
                NavigationView{
                    TabView{
                        CatalogView()
                            .tabItem{
                                Label("Catalog", systemImage: "numbersign")
                            }
                        SearchView()
                            .tabItem{
                                Label("Search", systemImage: "plus.circle")
                            }
                        BookMarkView()
                            .tabItem{
                                Label("Bookmarks", systemImage: "bookmark")
                            }
                        SignOutView()
                            .tabItem{
                                Label("Sign out", systemImage: "power")
                            }
                        
                    }.accentColor(.primary)
                        .alert(isPresented: .constant(self.showAlert)){
                            Alert(title: Text("Enjoying Loku?"),
                                  message: Text("Rate us on the app store!"),
                                  primaryButton: .default(Text("Ok!")),
                                  secondaryButton: .default(Text("Maybe Later"))
                            )
                        }
                }
                
            } else {
                InitialSelectionView()
            }
        }
        .onChange(of: scenePhase){ phase in

            if phase == .active{
                opened.openedCount += 1
            }
            opened.save()
        }
    }
}
        
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(AppViewModel())
            .environmentObject(ObservedResults())
            .environmentObject(Catalog())
            .environmentObject(Bookmarks())
            .environmentObject(DisplayMessage())
            
    }
}
