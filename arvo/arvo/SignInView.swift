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
                    TextField("", text: $email)
                        .keyboardType(.emailAddress)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemFill))
                        .foregroundColor(.white)
                        .cornerRadius(20)
                        .placeholder(when: email.isEmpty) {
                            Text("email").foregroundColor(.white)
                                .padding(.leading, 20)
                                .font(.custom("times", fixedSize: 20))
                                .bold()
                        }
                    
                    SecureField("", text: $password)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemFill))
                        .foregroundColor(.white)
                        .cornerRadius(20)
                        .placeholder(when: password.isEmpty) {
                            Text("password").foregroundColor(.white)
                                .padding(.leading, 20)
                                .font(.custom("times", fixedSize: 20))
                                .bold()
                        }
                    
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

