//
//  UserProfileView.swift
//  arvo
//
//  Created by reed kuivila on 3/7/23.
//

import SwiftUI
import Foundation
import FirebaseFirestore

struct UserProfileView: View {
    let displayName = "some name"
    let displayEmail = "some email"

    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                VStack {
                    Image(systemName: "person.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 200, height: 200)
                        .clipShape(Circle())
                        .clipped()
                        .padding(.top, 44)
                    
                    Text(displayName)
                        .font(.custom("times", fixedSize: 25))
                        .bold()
                        .foregroundColor(.black)
                        .padding(.top, 10)
                                    
                    Text(displayEmail)
                        .font(.custom("times", fixedSize: 20))
                        .bold()
                        .foregroundColor(.black)
                        .padding(.top, 1)
                    
                    
                }
                Spacer()
            }
            Spacer()
        }
        
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
