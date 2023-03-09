//
//  SignInView.swift
//  arvo
//
//  Created by reed kuivila on 3/7/23.
// https://www.youtube.com/watch?v=vPCEIPL0U_k&ab_channel=iOSAcademy

import SwiftUI

// code to sign in if account is created
struct SignInView: View {
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
                
                VStack {
                    TextField("email address", text: $email)
                        .keyboardType(.emailAddress)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemFill))
                        .foregroundColor(.orange)
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
                    
                    NavigationLink("not a member? sign up here", destination: SignUpView())
                        .padding()
                }
        
                .padding()
                Spacer()
            }
            .background(LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom))
            .edgesIgnoringSafeArea(.all)
//            .navigationTitle("user login")
        }
    }
