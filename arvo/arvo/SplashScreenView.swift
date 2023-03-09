//
//  SplashScreenView.swift
//  arvo
//
//  Created by reed kuivila on 3/9/23.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            ZStack{
                Color(#colorLiteral(red: 0.1924162178, green: 0.1908109435, blue: 0.1929768041, alpha: 1)).ignoresSafeArea()
                VStack{
                    VStack {
                        Image(systemName: "popcorn.circle.fill")
                            .font(.system(size: 80))
                            .foregroundColor(.purple)
                        Text("welcome to loku")
                            .font(.custom("times", fixedSize: 35).bold())
                            .foregroundColor(.white.opacity((0.8)))
                    }
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeIn(duration: 1.2)) {
                            self.size = 0.9
                            self.opacity = 1.0
                        }
                    }
                }
                
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    self.isActive = true
                }
                }
            }
        }
    }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
