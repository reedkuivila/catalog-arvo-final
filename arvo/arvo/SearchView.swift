//
//  ContentView.swift
//  Catalog
//
//  Created by Amol Gundeti on 3/2/23.
//

import SwiftUI

struct ToastModifier: ViewModifier{
    @Binding var isShowing: Bool
    var catalogEntries: Int
    var movieTitle: String
    @Binding var displayMessage: String
    let duration: TimeInterval
    
    func body(content: Content) -> some View {
        ZStack{
            content
            
            if isShowing{
            VStack{
                Spacer()
                HStack{
                    Image(systemName: "heart")
                        .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                    if (catalogEntries < 3){
                    Text(displayMessage)
                        .foregroundColor(Color.white)}
                    else{
                        Text(displayMessage)
                            .foregroundColor(Color.white)
                    }
                    Spacer()
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .background(Color.black)
                .cornerRadius(10)
                .shadow(radius: 5)
            }
                .padding()
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + duration){
                        withAnimation{
                            isShowing = false
                        }
                    }
                }
                .onTapGesture {
                    isShowing = false
                }
            }
            
        }
    }
}


extension View{
    func toast(isShowing: Binding<Bool>, duration: TimeInterval = 3, catalogEntries: Int, movieTitle: String, displayMessage: Binding<String>) -> some View{
        modifier(ToastModifier(isShowing: isShowing, catalogEntries: catalogEntries, movieTitle: movieTitle, displayMessage: displayMessage, duration: 1))
    }
}

struct SearchView: View {
    
    @State var searchText = ""
    @EnvironmentObject var observedResults: ObservedResults
    @EnvironmentObject var catalog: Catalog
    @EnvironmentObject var bookmarks: Bookmarks
    @State private var showRating = false
    @State var showingBottomSheet = false
    @State private var clickedMovie = TmdbEntry(popularity: 98.041, voteCount: 14983, video: false, posterPath: "/t3vaWRPSf6WjDSamIkKDs1iQWna.jpg", id: 2062, adult: false, backdropPath: "/xgDj56UWyeWQcxQ44f5A3RTWuSs.jpg", originalLanguage: "en", originalTitle: "Ratatouille", genreIDS: [16,35,10751, 14], title: "Ratatouille", voteAverage: 7.795, overview: "Remy, a resident of Paris, appreciates good food and has quite a sophisticated palate.", releaseDate: "2007-06-28", mediaType: "movie")
    @State private var isShowingToast = false
    @State var displayMessage = ""
    @EnvironmentObject public var viewModel: AppViewModel


    
    var body: some View {
        NavigationView{
            ZStack{
            
            let searchResults = observedResults.results.count
            if searchResults > 0{
            VStack{
                List(observedResults.results, id: \.id) { item in
                    
                    let added = self.catalog.addedMovies.keys.contains(item.id!)
                    let bookmarked = self.bookmarks.bookmarkedMovies.keys.contains(item.id!)
                    
                    NavigationLink{
                        DetailView(movie: item)
                    } label: {
                        VStack(alignment: .leading) {
                            HStack{
                                
                                VStack(alignment: .leading){
                                Text(item.originalTitle!)
                                    .font(.headline)
                                    .foregroundColor(Color.white)
                                    Spacer().frame(height:2)
                                    Text("\(formatDate(date:item.releaseDate!, mode: 0) ?? "") ")
                                        .foregroundColor(.white)
                                }
                                Spacer()
                                
                                if !added{
                                Button(action: {
                                
                                    if bookmarked{
                                        self.bookmarks.bookmarkedMovies.removeValue(forKey: item.id!)
                                        self.bookmarks.results = self.bookmarks.results.filter{$0.id != item.id}
                                    } else{
                                        self.bookmarks.results.append(item)
                                        self.bookmarks.bookmarkedMovies[item.id!] = item.id!
                                        self.bookmarks.save()
                                        displayMessage = "Bookmarked \(item.title!)!"
                                        self.isShowingToast.toggle()
                                    }
                                    
                                    self.bookmarks.save()
                                    }, label: {
                                        let bookmarked = self.bookmarks.bookmarkedMovies.keys.contains(item.id!)
                                        if bookmarked{
                                            Image(systemName: "bookmark.fill")
                                                .foregroundColor(.white)
                                        } else{
                                            Image(systemName: "bookmark")
                                                .foregroundColor(.white)
                                        }
                                }).buttonStyle(PlainButtonStyle())
                             }
                                
                                Button(action: {
                                    clickedMovie = item
                                    
                                    if catalog.addedMovies.keys.contains(item.id!){
                                        displayMessage = "Already added \(item.title!)"
                                        self.isShowingToast.toggle()
                                    } else{
                                        if catalog.results.count < 2{
                                        catalog.results.append(item)
                                            catalog.addedMovies[item.id!] = item.id!
                                        displayMessage = "Added \(String(describing: item.title!))! Add \(3-catalog.results.count) More to generate ratings"
                                        self.isShowingToast.toggle()
                                        
                                    } else{
                                        displayMessage = "Added \(String(describing: item.title))!"
                                        self.showingBottomSheet.toggle()
                                        self.isShowingToast.toggle()
                                        }
                                    }
                                    
                                    
                                }, label: {
                                    
                                    if added{
                                        Image(systemName: "checkmark.circle.fill").foregroundColor(.white)
                                    }else{
                                    Image(systemName: "plus.circle").foregroundColor(.white)
                                        
                                    }
                                }).buttonStyle(PlainButtonStyle())
                                
                            }
                        }
                    }
                    .listRowBackground(Color.black)
                        .listRowSeparatorTint(.white)
                }
                .background(Color(#colorLiteral(red: 0.1924162178, green: 0.1908109435, blue: 0.1929768041, alpha: 1)))
                    .scrollContentBackground(.hidden)
                
                }
            } else{
                ZStack{
                    Color(#colorLiteral(red: 0.1924162178, green: 0.1908109435, blue: 0.1929768041, alpha: 1))
                    VStack{
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .scaledToFill()
                        .foregroundColor(Color(#colorLiteral(red: 0.1123900237, green: 0.1114523854, blue: 0.1127174613, alpha: 1)))
                        .frame(width: 100, height: 100)
                        Spacer().frame(height: 50)
                        Text("Search for movies")
                            .font(.headline)
                            .foregroundColor(Color(#colorLiteral(red: 0.1123900237, green: 0.1114523854, blue: 0.1127174613, alpha: 1)))
                    }
                }
            }
            }
            .toast(isShowing: $isShowingToast, catalogEntries: catalog.results.count, movieTitle: clickedMovie.title ?? "", displayMessage: $displayMessage)
            .navigationBarTitle("Search")
        }.toolbar{
            ToolbarItem{
                Button(action: {
                    viewModel.signOut()

                }, label: {
                    Text("sign out")
                        .frame(width: 200, height: 50)
                        .foregroundColor(Color.black)
                        .background(Color.white)
                        .padding()
                })

            }
        }
        .searchable(text: $searchText, prompt: "Search for movies")
        .autocorrectionDisabled(true)
        .keyboardType(.default)
        .font(.body).foregroundColor(.white)
        .onSubmit(of: .search, {Task{
            await callTMDB()
            }})
        
        .sheet(isPresented: $showingBottomSheet){
            RatingView(movie: $clickedMovie, rightIndex: catalog.results.count-1, showingBottomSheet: $showingBottomSheet)
                .presentationDetents([.medium, .large])
        }
    }
        
    
    func callTMDB() async{
            
            let searchTermUrl = searchText.replacingOccurrences(of: " ", with: "+")
            
            guard let movieUrl = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=ccc1083f814b898f8cd1b7a97b5f9b1b&query=\(searchTermUrl)") else
            {
                print("invalid URL")
                return
            }
        
            
            do{
                let (data,_) = try await URLSession.shared.data(from: movieUrl)
                
                if let decodedResponse = try? JSONDecoder().decode(TmdbResponse.self, from: data) {
                    self.observedResults.results = decodedResponse.results
                    }
                
            } catch{
                print("inavlid data")
            }
        
    }

}

struct SearchView_Previews: PreviewProvider {
    
    static var previews: some View {
        SearchView().environmentObject(ObservedResults()).environmentObject(Catalog()).environmentObject(Bookmarks())
    }
    
}

//get data back and dump into local database
//save entire TmdbEntry
//Cache images
