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
    
    let gradient = Gradient(colors: [.gray, .black])

    var body: some View {
            VStack {
                Image("lokulogo")
                    .resizable()
                    .scaledToFit()
                    .blur(radius: 0.5)
                    .padding(.top, 65)
//                    .frame(width: 150, height: 150)
                
                VStack {
                    TextField("first name", text: $firstName)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemFill))
                        .cornerRadius(20)
                    
                    TextField("email address", text: $email)
                        .keyboardType(.emailAddress)
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
                            .font(.custom("times", fixedSize: 20.0).bold())
                            .foregroundColor(Color.black)
                            .frame(width: 200, height: 50)
                            .background(Color.white)
                            .cornerRadius(20)
                        
                    })
                }
                .padding()
                Spacer()
            }
            .background(LinearGradient(gradient: gradient, startPoint: .bottom, endPoint: .top))
            .edgesIgnoringSafeArea(.all)
        }
    }
