//
//  DetailView.swift
//  Catalog
//
//  Created by Amol Gundeti on 3/6/23.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var catalog: Catalog
    @EnvironmentObject var bookmarks: Bookmarks
    @State var displayMessage = ""
    @State var showingBottomSheet = false
    @State var clickedMovie = TmdbEntry(popularity: 98.041, voteCount: 14983, video: false, posterPath: "/t3vaWRPSf6WjDSamIkKDs1iQWna.jpg", id: 2062, adult: false, backdropPath: "/xgDj56UWyeWQcxQ44f5A3RTWuSs.jpg", originalLanguage: "en", originalTitle: "Ratatouille", genreIDS: [16,35,10751, 14], title: "Ratatouille", voteAverage: 7.795, overview: "Remy, a resident of Paris, appreciates good food and has quite a sophisticated palate. He would love to become a chef so he can create and enjoy culinary masterpieces to his heart's delight. The only problem is, Remy is a rat. When he winds up in the sewer beneath one of Paris' finest restaurants, the rodent gourmet finds himself ideally placed to realize his dream.", releaseDate: "2007-06-28", mediaType: "movie")
    
    var movie = TmdbEntry(popularity: 98.041, voteCount: 14983, video: false, posterPath: "/t3vaWRPSf6WjDSamIkKDs1iQWna.jpg", id: 2062, adult: false, backdropPath: "/xgDj56UWyeWQcxQ44f5A3RTWuSs.jpg", originalLanguage: "en", originalTitle: "Ratatouille", genreIDS: [16,35,10751, 14], title: "Ratatouille", voteAverage: 7.795, overview: "Remy, a resident of Paris, appreciates good food and has quite a sophisticated palate. He would love to become a chef so he can create and enjoy culinary masterpieces to his heart's delight. The only problem is, Remy is a rat. When he winds up in the sewer beneath one of Paris' finest restaurants, the rodent gourmet finds himself ideally placed to realize his dream.", releaseDate: "2007-06-28", mediaType: "movie")
    
    init(movie: TmdbEntry){
        self.movie = movie
    }
    
    var body: some View {
        let movieURL = URL(string: "https://image.tmdb.org/t/p/w780\(movie.posterPath!)")
        let added = self.catalog.addedMovies.keys.contains(movie.id!)
        let bookmarked = self.bookmarks.bookmarkedMovies.keys.contains(movie.id!)
       
            ZStack{
                ZStack(alignment: .topLeading){
                    //Attribution: https://www.youtube.com/watch?v=EFnUwG22fHk
                    AsyncImage(url: movieURL) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(height: 800, alignment: .topLeading)
                            .edgesIgnoringSafeArea(.top)
                    } placeholder: {
                        ProgressView()
                    }
                    Blur(style: .light)
                        .frame(height: 800  , alignment: .topLeading)
                    //                        .edgesIgnoringSafeArea(.top)
                    AsyncImage(url: movieURL) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(height: 800, alignment: .topLeading)
                            .edgesIgnoringSafeArea(.top)
                            .mask(LinearGradient(gradient:
                                                    Gradient(stops:[
                                                        .init(color: Color.black, location:0),
                                                        .init(color: Color.black, location: 0.15),
                                                        .init(color: Color.black.opacity(0), location: 1)
                                                    ]
                                                    ), startPoint: .top, endPoint: .bottom))
                    } placeholder: {
                        ProgressView()
                    }
                }
                VStack{
                    ScrollView{
                        Spacer().frame(height: 550)
                        
                        ZStack{
                            Color(#colorLiteral(red: 0.1924162178, green: 0.1908109435, blue: 0.1929768041, alpha: 1))
                            VStack(alignment: .leading){
                                HStack{
                                    Text(movie.originalTitle!)
                                        .font(.system(size: 32))
                                        .fontWeight(.heavy)
                                        .foregroundColor(Color.white)
                                        .multilineTextAlignment(.leading)
                                    Spacer()
                                    
                                    if !added{
                                        
                                        Button(action: {
                                            self.clickedMovie = movie
                                            if bookmarked{
                                                self.bookmarks.bookmarkedMovies.removeValue(forKey: movie.id!)
                                                self.bookmarks.results = self.bookmarks.results.filter{$0.id != movie.id}
                                            } else{
                                                self.bookmarks.results.append(movie)
                                                self.bookmarks.bookmarkedMovies[movie.id!] = movie.id!
                                                self.bookmarks.save()
                                                displayMessage = "Bookmarked \(movie.title!)!"
                                            }
                                            
                                            self.bookmarks.save()
                                        }, label: {
                                            let bookmarked = self.bookmarks.bookmarkedMovies.keys.contains(movie.id!)
                                            if bookmarked{
                                                Image(systemName: "bookmark.fill")
                                                    .foregroundColor(.white)
                                            } else{
                                                Image(systemName: "bookmark")
                                                    .foregroundColor(.white)
                                            }
                                        }).buttonStyle(PlainButtonStyle())
                                        
                                        Button(action: {
                                            self.clickedMovie = movie
                                                if catalog.results.count < 2{
                                                    catalog.results.append(movie)
                                                    catalog.addedMovies[movie.id!] = movie.id!
                                                    displayMessage = "Added \(String(describing: movie.title!))! Add \(3-catalog.results.count) More to generate ratings"
                                                    
                                                } else{
                                                    displayMessage = "Added \(String(describing: movie.title))!"
                                                    self.showingBottomSheet.toggle()
                                                }
                                            
                                        }, label: {
                                                Image(systemName: "plus.circle")
                                                .foregroundColor(.white)
                                        }).buttonStyle(PlainButtonStyle())
                                    } else{
                                    HStack{

                                        DropDown(movie: movie, clickedMovie: $clickedMovie, showingBottomsheet: $showingBottomSheet)
                                    }
                                        
                                    }
                                    
                                }
                                
                                ScrollView(.horizontal){
                                    HStack{
                                        ForEach(movie.genreIDS!, id: \.self){ genre in
                                            Text("\(genreIDToString(genre)) |")
                                                .foregroundColor(.white)
                                        }
                                    }
                                }
                                
                                Text("\(formatDate(date: movie.releaseDate ?? "", mode: 1) ?? "")")
                                    .foregroundColor(.white)
                                
                                Rectangle()
                                    .frame(height:2)
                                    .foregroundColor(.white)
                                
                                Text(movie.overview!)
                                    .font(.body)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.white)
                                    .multilineTextAlignment(.leading)
                                
                                Rectangle()
                                    .frame(height:2)
                                    .foregroundColor(.white)
                                Rectangle()
                                    .frame(height:30)
                                    .foregroundColor(Color(#colorLiteral(red: 0.1924162178, green: 0.1908109435, blue: 0.1929768041, alpha: 1)))
                                
                            }.padding()
                            
                            
                        }
                        
                        
                    }
                }
                
            }
        
            .toolbar{
                ShareLink(item: "Check out this movie! https://www.themoviedb.org/movie/\(self.movie.id!)")
            }
            .sheet(isPresented: $showingBottomSheet){
                RatingView(movie: $clickedMovie, rightIndex: catalog.results.count-1, showingBottomSheet: $showingBottomSheet)
                .presentationDetents([.medium, .large])}
            .toast(catalogEntries: catalog.results.count, movieTitle: clickedMovie.title ?? "")
        
        }
}

struct DetailView_Previews: PreviewProvider {
    static var movie = TmdbEntry(popularity: 98.041, voteCount: 14983, video: false, posterPath: "/t3vaWRPSf6WjDSamIkKDs1iQWna.jpg", id: 2062, adult: false, backdropPath: "/xgDj56UWyeWQcxQ44f5A3RTWuSs.jpg", originalLanguage: "en", originalTitle: "Ratatouille", genreIDS: [16,35,10751, 14], title: "Ratatouille", voteAverage: 7.795, overview: "Remy, a resident of Paris, appreciates good food and has quite a sophisticated palate. He would love to become a chef so he can create and enjoy culinary masterpieces to his heart's delight. The only problem is, Remy is a rat. When he winds up in the sewer beneath one of Paris' finest restaurants, the rodent gourmet finds himself ideally placed to realize his dream.", releaseDate: "2007-06-28", mediaType: "movie")
    
    static var previews: some View {
        
        DetailView(movie: movie).environmentObject({ () -> Bookmarks in
            
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
