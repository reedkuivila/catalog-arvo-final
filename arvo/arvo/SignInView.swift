//
//  SignInView.swift
//  arvo
//
//  Created by reed kuivila on 3/7/23.
//

import SwiftUI

// code to sign in if account is created
struct SignInView: View {
    @State var email = ""
    @State var password = ""
    
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
            VStack {
                Image(systemName: "camera.filters")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                
                VStack {
                    TextField("email address", text: $email)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemFill))
                        .cornerRadius(20)
                    
                    SecureField("password", text: $password)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemFill))
                        .cornerRadius(20)
                    
                    Button(action: {
                        
                        // logic to only press sign in button if fields are filled
                        guard !email.isEmpty, !password.isEmpty else {
                            return
                        }
                        viewModel.emailSignIn(email: email, password: password)
                        
                    }, label: {
                        Text("sign in")
                            .foregroundColor(Color.black)
                            .frame(width: 200, height: 50)
                            .background(Color.white)
                            .cornerRadius(20)
                        
                    })
                    NavigationLink("create account", destination: SignUpView())
                        .padding()
                }
                .padding()
                Spacer()
            }
            .navigationTitle("user login")
        }
    }
