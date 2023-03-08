//
//  SignUpView.swift
//  arvo
//
//  Created by reed kuivila on 3/7/23.
//

import SwiftUI

// code to make account if account does not exist
struct SignUpView: View {
    @State var firstName = ""
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
                    TextField("first name", text: $firstName)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemFill))
                        .cornerRadius(20)
                    
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
                        viewModel.emailSignUp(email: email, password: password)
                        
                    }, label: {
                        Text("create account")
                            .foregroundColor(Color.black)
                            .frame(width: 200, height: 50)
                            .background(Color.white)
                            .cornerRadius(20)
                        
                    })
                }
                .padding()
                Spacer()
            }
            .navigationTitle("create account")
        }
    }
