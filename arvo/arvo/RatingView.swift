//
//  RatingView.swift
//  Catalog
//
//  Created by Amol Gundeti on 3/3/23.
//

import SwiftUI

//View for rating sheet - holds core logic for rating movies. Operates on a form of bisection Search
    //Say user wants to add Batman
    //Always starts at the middle of the catalog array
    //moves through array on whether Batman "wins" or "loses" a matchup with a movie at that point in the array
    //Runs through log(n) match ups where n is length of catalog array


struct RatingView: View {
    
    @EnvironmentObject var catalog: Catalog
    @EnvironmentObject var bookmarks: Bookmarks
    @EnvironmentObject var displayMsg: DisplayMessage
    @State private var leftIndex: Int = 0
    @State private var rightIndex: Int
    @Binding var showingBottomSheet: Bool
    @Binding var movie: TmdbEntry
    
    //computed property essential for fetching the next movie in the matchup
    var middleIndex: Int {
        let index = self.floorDivInt(self.leftIndex, self.rightIndex)
        
        if index >= 0{
            return index
        } else{
            return 0
        }
    }
    
    //URL for competitor movie
    var comparisonURL: URL{
        return URL(string:"https://image.tmdb.org/t/p/w300/\(catalog.results[self.middleIndex].posterPath ?? "")")!
    }
    
    var comparisonMovie: TmdbEntry{
        return catalog.results[self.middleIndex]
    }
    
    //Computed property for checking if the search is completed
        //Has a bug where need to tap twice if comparing against the first movie in the array. Unsure why
    var isDone: Bool{
        if leftIndex < rightIndex {
            return false
        }  else{
            return true
        }
    }
    
    init(movie: Binding<TmdbEntry>, rightIndex: Int, showingBottomSheet: Binding<Bool>) {
        self._movie = movie
        self.leftIndex = 0
        self.rightIndex = rightIndex
        self._showingBottomSheet = showingBottomSheet
    }
    
    var body: some View {
        ZStack{
            Color(#colorLiteral(red: 0.3174360069, green: 0.3174360069, blue: 0.3174360069, alpha: 1)).ignoresSafeArea()
            VStack{
                Text("Which movie do you like more?")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                HStack{
                    let movieURL = URL(string: "https://image.tmdb.org/t/p/w300/\(movie.posterPath ?? "")")
                    
                    VStack{
                        
                        //Button for declaring movie to be added as the winner of a matchup
                        Button{
                            print("Choose \(movie.originalTitle!). Moving up")
                            if !self.isDone{
                                if self.middleIndex == 0{
                                    self.rightIndex = 0
                                } else{
                                    self.rightIndex = self.middleIndex - 1
                                }
                                print("New Indexes: left: \(self.leftIndex), right \(self.rightIndex), middle: \(self.middleIndex)")
                            } else{
                                self.catalog.results.insert(movie, at: self.middleIndex)
                                self.catalog.addedMovies[movie.id!] = movie.id
                                
                                if self.bookmarks.bookmarkedMovies.keys.contains(movie.id!){
                                    self.bookmarks.bookmarkedMovies.removeValue(forKey: movie.id!)
                                    print("deleting \(movie.originalTitle!) from bookmarks. Old length: \(self.bookmarks.results.count)")
                                    self.bookmarks.results = self.bookmarks.results.filter{
                                        $0.id! != movie.id!}
                                }
                                
                                print("Added \(movie.originalTitle!) to catalog and saving")
                                self.catalog.save()
                                self.bookmarks.save()
                                self.displayMsg.isShowingToast.toggle()
                                self.showingBottomSheet = false
                            }
                        } label: {
                            AsyncImage(url: movieURL) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 150, height: 250)
                            .shadow(radius: 5)
                            .cornerRadius(5)
                        }.buttonStyle(PlainButtonStyle())
                        Spacer().frame(height: 10)
                        

                    }

                    //Button for declaring comparison movie as the winner of a matchup
                    VStack{
                        Button{
                            print("Choose \(comparisonMovie.originalTitle!). Moving down")
                            if !self.isDone{
                                self.leftIndex = self.middleIndex + 1
                                print(self.middleIndex)
                                print("New Indexes: left: \(self.leftIndex), right \(self.rightIndex), middle: \(self.middleIndex)")
                            } else{
                                if self.middleIndex < self.catalog.results.count - 1{
                                    self.catalog.results.insert(movie, at: self.middleIndex + 1)
                                    self.catalog.addedMovies[movie.id!] = movie.id
                                }else{
                                    self.catalog.results.append(movie)
                                    self.catalog.addedMovies[movie.id!] = movie.id
                                }
                                print("Added \(movie.originalTitle!) to catalog and saving")
                                self.catalog.save()
                                
                                if self.bookmarks.bookmarkedMovies.keys.contains(movie.id!){
                                    self.bookmarks.bookmarkedMovies.removeValue(forKey: movie.id!)
                                    print("deleting key. Old length: \(self.bookmarks.results.count)")
                                    self.bookmarks.results = self.bookmarks.results.filter{
                                        $0.id! != movie.id!}
                                    print("deleted key. New length: \(self.bookmarks.results.count)")
                                }
                                self.bookmarks.save()
                                self.displayMsg.isShowingToast.toggle()
                                self.showingBottomSheet = false
                            }
                            
                            
                        } label: {
                            AsyncImage(url: comparisonURL) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 150, height: 250)
                            .shadow(radius: 5)
                            .cornerRadius(5)
                            
                        }.buttonStyle(PlainButtonStyle())
                        
                        Spacer().frame(height: 10)
//                        Text("\(self.comparisonMovie.originalTitle!)")
//                            .font(.body)
//                            .fontWeight(.semibold)
//                            .lineLimit(1)
//                            .foregroundColor(.white)
                    }
                }.padding()
            }.padding()
            
            Text("VS")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.black)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center)
                .padding()
                .frame(width: 65, height: 65)
                .background(Circle().fill(Color.white))
                .shadow(color: .white, radius: 3)
                

        
        }
    }
    
    func addMovie(){
        self.catalog.results.append(self.movie)
    }
    
    func floorDivInt(_ left: Int, _ right: Int) -> Int{
        return Int(floor((Double(left)+Double(right))/2))
    }
}

struct RatingView_Previews: PreviewProvider {
    @State static var tempMovie = TmdbEntry(popularity: 98.041, voteCount: 14983, video: false, posterPath: "/t3vaWRPSf6WjDSamIkKDs1iQWna.jpg", id: 2062, adult: false, backdropPath: "/xgDj56UWyeWQcxQ44f5A3RTWuSs.jpg", originalLanguage: "en", originalTitle: "Ratatouille", genreIDS: [16,35,10751, 14], title: "Ratatouille", voteAverage: 7.795, overview: "Remy, a resident of Paris, appreciates good food and has quite a sophisticated palate.", releaseDate: "2007-06-28", mediaType: "movie")
    
    @State static var showingBottomSheet = true
    @State static var toaster = true
    
    
    static var previews: some View {
        RatingView(movie: $tempMovie, rightIndex: 0, showingBottomSheet: $showingBottomSheet).environmentObject({ () -> Catalog in
            
            let catalogPreview = Catalog()
            catalogPreview.results.append(TmdbEntry(popularity: 98.041, voteCount: 14983, video: false, posterPath: "/t3vaWRPSf6WjDSamIkKDs1iQWna.jpg", id: 2062, adult: false, backdropPath: "/xgDj56UWyeWQcxQ44f5A3RTWuSs.jpg", originalLanguage: "en", originalTitle: "Ratatouille", genreIDS: [16,35,10751, 14], title: "Ratatouille", voteAverage: 7.795, overview: "Remy, a resident of Paris, appreciates good food and has quite a sophisticated palate.", releaseDate: "2007-06-28", mediaType: "movie"))
            
            return catalogPreview
        }())
        .environmentObject(DisplayMessage())
    }
}
