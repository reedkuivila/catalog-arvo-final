//
//  ContentView.swift
//  Final Project AG RK
//
//  Created by reed kuivila on 2/27/23.
//

// README
// color RGB valiues can be found here
// https://www.schemecolor.com/70s-retro.php


import SwiftUI

struct InitialSelectionView: View {
    @State private var showInitial = true

    
    var body: some View {
        // display name and user prompt
        // should brainstorm better options
        // should edit font and consider logo
        VStack{
            NavigationStack{
            Text("arvo")
                .font(.custom("times", fixedSize: 100.0))
                .fontWeight(.bold)
                .padding(.top, 150)
            
            Text("movies done better")
                .font(.custom("times", fixedSize: 35.0))
            
            // VStack to add login or sign up button
            // should consider language of "sign in" or "login" and figure out which sounds better
                VStack(alignment: .leading) {
                    Spacer()
                    // login button
                    NavigationLink(destination: SignInView()){
                        Button(action: { }) {
                            Text("login")
                                .font(.title2)
                                .bold()
                                .foregroundColor(.white)
                        }
                        .frame(height: 60)
                        .frame(maxWidth: .infinity)
                        .background(Color(red: 242/255, green: 138/255, blue: 15/255))
                        .cornerRadius(15)
                        .padding(20)
                    }
                    
                    // create account button
                    // TODO: to make create account page and add navigation link
                    NavigationLink(destination: PhoneAuthentication()) {
                        Button {
                            print("go to create account page")
                        } label: {
                            Text("create account")
                                .font(.title2)
                                .bold()
                                .foregroundColor(.white)
                        }
                        .frame(height: 60)
                        .frame(maxWidth: .infinity)
                        .background(.red)
                        .cornerRadius(15)
                        .padding(20)
                    }
                    
                }
            }
                
                // cream color background - whole page
//                .background(Color(red: 255.0/255.0,
//                                  green: 231.0/255.0,
//                                  blue: 180.0/255.0))
//                .opacity(0.4)
//                .navigationViewStyle(.automatic)
            
        }
    }
}


struct InitialSelectionView_Preview: PreviewProvider {
    static var previews: some View {
        InitialSelectionView()
    }
}


