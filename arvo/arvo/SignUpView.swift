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
                Image(systemName: "popcorn.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .blur(radius: 0.5)
                    .padding(.top, 105)
                    .foregroundColor(.purple)
                    .opacity(0.5)
                    .frame(width: 250, height: 250)
                
                VStack {
                    TextField("", text: $firstName)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemFill))
                        .foregroundColor(.white)
                        .cornerRadius(20)
                        .placeholder(when: firstName.isEmpty) {
                            Text("First name").foregroundColor(.white)
                                .padding(.leading, 20)
                                .bold()

                        }
                       
                    
                    TextField("", text: $email)
                        .keyboardType(.emailAddress)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemFill))
                        .foregroundColor(.white)
                        .cornerRadius(20)
                        .placeholder(when: email.isEmpty) {
                            Text("Email").foregroundColor(.white)
                                .padding(.leading, 20)
                                .bold()
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
                            Text("Password").foregroundColor(.white)
                                .padding(.leading, 20)
                                .bold()
                        }
                    
                    Button(action: {
                        
                        // logic to only press sign in button if fields are filled
                        guard !email.isEmpty, !password.isEmpty else {
                            return
                        }
                        viewModel.emailSignUp(email: email, password: password)
                        
                    }, label: {
                        Text("Create account")
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

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
