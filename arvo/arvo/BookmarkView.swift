//
//  CatalogView.swift
//  Catalog
//
//  Created by Amol Gundeti on 3/5/23.
//

import SwiftUI

struct BookMarkView: View {
    
    @EnvironmentObject var bookmarks: Bookmarks
    @EnvironmentObject var catalog: Catalog
    @State private var isShowingToast = false
    @State private var showingBottomSheet = false
    @State private var clickedMovie = TmdbEntry(popularity: 98.041, voteCount: 14983, video: false, posterPath: "/t3vaWRPSf6WjDSamIkKDs1iQWna.jpg", id: 2062, adult: false, backdropPath: "/xgDj56UWyeWQcxQ44f5A3RTWuSs.jpg", originalLanguage: "en", originalTitle: "Ratatouille", genreIDS: [16,35,10751, 14], title: "Ratatouille", voteAverage: 7.795, overview: "Remy, a resident of Paris, appreciates good food and has quite a sophisticated palate.", releaseDate: "2007-06-28", mediaType: "movie")
    
    @State var displayMessage = ""

    var body: some View {
        
        let bookmarksWithIndex = bookmarks.results.enumerated().map({ $0 })
        let totalBookmarks = bookmarks.results.count
        
        NavigationStack{
            ZStack{
            if totalBookmarks > 0 {
                List(bookmarksWithIndex, id: \.1.id) { idx, item in
                    
                    NavigationLink{
                        DetailView(movie: item)
                    } label: {
                        VStack(alignment: .leading) {
                            HStack{
                                Text(item.originalTitle!)
                                    .font(.headline)
                                    .foregroundColor(Color.white)
                                Spacer()
                                
                                Button(action: {
                                    self.clickedMovie = item
                                    if catalog.addedMovies.keys.contains(item.id!){
                                        displayMessage = "Already added \(item.title!)"
                                        self.isShowingToast.toggle()
                                    } else{
                                        if catalog.results.count < 2{
                                            catalog.results.append(item)
                                            self.isShowingToast.toggle()
                                            print(self.catalog.results)
                                            
                                        } else{
                                            self.showingBottomSheet.toggle()
                                        }
                                    }
                                }, label: {
                                    Image(systemName: "plus.circle")
                                        .foregroundColor(.white)
                                }).buttonStyle(PlainButtonStyle())
                                
                                Button(action: {
                                    self.bookmarks.bookmarkedMovies.removeValue(forKey: item.id!)
                                    self.bookmarks.results = self.bookmarks.results.filter{$0.id != item.id}
                                    self.bookmarks.save()
                                }, label: {
                                    Image(systemName: "bookmark.fill")
                                        .foregroundColor(.white)
                                }).buttonStyle(PlainButtonStyle())
                            }

                    }
                    
                    }.listRowBackground(Color.black)
                        .listRowSeparatorTint(.white)
                }
            } else{
                ZStack{
                    Color(#colorLiteral(red: 0.1924162178, green: 0.1908109435, blue: 0.1929768041, alpha: 1))
                    VStack{
                    Image(systemName: "bookmark.fill")
                        .resizable()
                        .scaledToFill()
                        .foregroundColor(Color(#colorLiteral(red: 0.1123900237, green: 0.1114523854, blue: 0.1127174613, alpha: 1)))
                        .frame(width: 100, height: 100)
                        Spacer().frame(height: 50)
                        Text("Bookmarks will appear here")
                            .font(.headline)
                            .foregroundColor(Color(#colorLiteral(red: 0.1123900237, green: 0.1114523854, blue: 0.1127174613, alpha: 1)))
                    }
                }
            }
        }
            .navigationBarTitle("Bookmarks")
            .background(Color(#colorLiteral(red: 0.1924162178, green: 0.1908109435, blue: 0.1929768041, alpha: 1)))
            .scrollContentBackground(.hidden)

        }.sheet(isPresented: $showingBottomSheet){
            RatingView(movie: $clickedMovie, rightIndex: catalog.results.count-1, showingBottomSheet: $showingBottomSheet)
                .presentationDetents([.medium, .large])
        }
        .toast(isShowing: $isShowingToast, catalogEntries: catalog.results.count, movieTitle: clickedMovie.title ?? "", displayMessage: $displayMessage)
    }
}

struct BookMarkView_Previews: PreviewProvider {
    static var previews: some View {
        BookMarkView().environmentObject({ () -> Bookmarks in
            
            let bookmarkPreview = Bookmarks()
            bookmarkPreview.results.append(TmdbEntry(popularity: 98.041, voteCount: 14983, video: false, posterPath: "/t3vaWRPSf6WjDSamIkKDs1iQWna.jpg", id: 2062, adult: false, backdropPath: "/xgDj56UWyeWQcxQ44f5A3RTWuSs.jpg", originalLanguage: "en", originalTitle: "Ratatouille", genreIDS: [16,35,10751, 14], title: "Ratatouille", voteAverage: 7.795, overview: "Remy, a resident of Paris, appreciates good food and has quite a sophisticated palate.", releaseDate: "2007-06-28", mediaType: "movie"))
            
            return bookmarkPreview
        }())
        .environmentObject({ () -> Catalog in
            
            let catalogPreview = Catalog()
            catalogPreview.results.append(TmdbEntry(popularity: 98.041, voteCount: 14983, video: false, posterPath: "/t3vaWRPSf6WjDSamIkKDs1iQWna.jpg", id: 2062, adult: false, backdropPath: "/xgDj56UWyeWQcxQ44f5A3RTWuSs.jpg", originalLanguage: "en", originalTitle: "Ratatouille", genreIDS: [16,35,10751, 14], title: "Ratatouille", voteAverage: 7.795, overview: "Remy, a resident of Paris, appreciates good food and has quite a sophisticated palate.", releaseDate: "2007-06-28", mediaType: "movie"))
            
            return catalogPreview
        }())
        
    }
}
