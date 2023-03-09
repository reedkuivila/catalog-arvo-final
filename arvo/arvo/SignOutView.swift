//
//  SignOutView.swift
//  arvo
//
//  Created by reed kuivila on 3/9/23.
//

import SwiftUI

struct SignOutView: View {
    @EnvironmentObject var viewModel: AppViewModel
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.1924162178, green: 0.1908109435, blue: 0.1929768041, alpha: 1)).ignoresSafeArea()
            
            Button(action: {
                viewModel.signOut()
                
            }, label: {
                Text("sign out")
                    .bold()
                    .foregroundColor(.white)
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(Color.purple.opacity(0.6))
                    .cornerRadius(15)
                    .padding(20)
                })
        }
    }
}


struct SignOutView_Previews: PreviewProvider {
    static var previews: some View {
        SignOutView()
    }
}
