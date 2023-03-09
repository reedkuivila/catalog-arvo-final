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
        Button(action: {
            viewModel.signOut()
            
        }, label: {
            Text("sign out")
                .font(.custom("times", fixedSize: 35))
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


struct SignOutView_Previews: PreviewProvider {
    static var previews: some View {
        SignOutView()
    }
}
