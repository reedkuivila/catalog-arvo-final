//
//  CatalogView.swift
//  Catalog
//
//  Created by Amol Gundeti on 3/5/23.
//

import SwiftUI

struct CatalogView: View {
    
    @EnvironmentObject var catalog: Catalog
    
    var body: some View {
        
        let catalogWithIndex = catalog.results.enumerated().map({ $0 })
        let catLen = catalog.results.count
        
        NavigationStack{
            List(catalogWithIndex, id: \.1.id) {idx, item in
                NavigationLink{
                    DetailView(movie: item)
                } label:{
                    VStack(alignment: .leading) {
                        HStack{
                            Text(item.originalTitle!)
                                .font(.headline)
                                .foregroundColor(.white)
                            Spacer()
                    
                            Text("\((1-Double(idx)/Double(catLen))*10, specifier: "%.1f")")
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                                .fixedSize(horizontal: false, vertical: true)
                                .multilineTextAlignment(.center)
                                .frame(width: 40, height: 40)
                                .background(Rectangle().fill(Color.black))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 2).stroke(.white, lineWidth: 1.5)
                                }
                        }
                    }
                
                }
                .listRowBackground(Color.black)
                .listRowSeparatorTint(.white)
            }
            .navigationTitle("Catalog")
            .background(Color(#colorLiteral(red: 0.1924162178, green: 0.1908109435, blue: 0.1929768041, alpha: 1)))
                .scrollContentBackground(.hidden)

        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct CatalogView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogView().environmentObject({ () -> Catalog in
            
            let catalogPreview = Catalog()
            catalogPreview.results.append(TmdbEntry(popularity: 98.041, voteCount: 14983, video: false, posterPath: "/t3vaWRPSf6WjDSamIkKDs1iQWna.jpg", id: 2062, adult: false, backdropPath: "/xgDj56UWyeWQcxQ44f5A3RTWuSs.jpg", originalLanguage: "en", originalTitle: "Ratatouille", genreIDS: [16,35,10751, 14], title: "Ratatouille", voteAverage: 7.795, overview: "Remy, a resident of Paris, appreciates good food and has quite a sophisticated palate.", releaseDate: "2007-06-28", mediaType: "movie"))
            
            return catalogPreview
        }())
        
    }
}
