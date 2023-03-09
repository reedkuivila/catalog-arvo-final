//
//  Instruction View.swift
//  arvo
//
//  Created by Amol Gundeti on 3/9/23.
//

import SwiftUI

struct InstructionView: View {
    var body: some View {
        ZStack{
            Color(#colorLiteral(red: 0.1924162178, green: 0.1908109435, blue: 0.1929768041, alpha: 1)).ignoresSafeArea()
            VStack(alignment: .leading){
                Text("Welcome to Loku!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                Spacer().frame(height:20)
                Rectangle()
                    .frame(height:2)
                    .foregroundColor(.white)
                HStack{
                    Image(systemName: "star")
                    Text("Search for movies to add in the search tab")
                        .foregroundColor(Color.white)
                        .fontWeight(.semibold)
                }
                HStack{
                    Image(systemName: "star")
                    Text("We'll generate ratings after you add your third movie")
                        .foregroundColor(Color.white)
                        .fontWeight(.semibold)
                }
                HStack{
                    Image(systemName: "star")
                    Text("Track your to-watchlist with bookmarks")
                        .foregroundColor(Color.white)
                        .fontWeight(.semibold)
                }
                
                HStack{
                    Image(systemName: "star")
                    Text("Rerate or delete movies from your catalog from detail pages for movies (accesible from the catalog tab)")
                        .foregroundColor(Color.white)
                        .fontWeight(.semibold)
                }

                


            }
        }
        
    }
}

struct Instruction_View_Previews: PreviewProvider {
    static var previews: some View {
        InstructionView()
    }
}
