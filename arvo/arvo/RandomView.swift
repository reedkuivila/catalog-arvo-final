//
//  RandomView.swift
//  Catalog
//
//  Created by Amol Gundeti on 3/7/23.
//

import SwiftUI


struct DropDown: View {
    @State var expanded = false
    @State var movie: TmdbEntry
    @Binding var showingBottomsheet: Bool
    @Binding var clickedMovie: TmdbEntry
    @EnvironmentObject var catalog: Catalog
    @EnvironmentObject var bookmarks: Bookmarks
    
    init(movie: TmdbEntry, clickedMovie: Binding<TmdbEntry>, showingBottomsheet: Binding<Bool>){
        self.movie = movie
        self._showingBottomsheet = showingBottomsheet
        self._clickedMovie = clickedMovie
    }

    
    var body: some View {
        Menu {
            
            //delete button
            Button {
                self.catalog.addedMovies.removeValue(forKey: movie.id!)
                self.catalog.results = self.catalog.results.filter{$0.id != movie.id}
            } label: {
                Text("Delete Movie")
                Image(systemName: "trash.circle")
                    .foregroundColor(.white)
            }
            
            //Rescore Movie Button
            Button {
                self.clickedMovie = self.movie
                self.catalog.addedMovies.removeValue(forKey: movie.id!)
                self.catalog.results = self.catalog.results.filter{$0.id != movie.id}
                self.showingBottomsheet.toggle()
            } label: {
                Text("Re-score Movie")
                Image(systemName: "arrow.up.and.line.horizontal.and.arrow.down")
            }
            
        } label: {
             Image(systemName: "list.dash")
                .resizable()
                .scaledToFill()
                .foregroundColor(.gray)
                .frame(width: 15, height:15)
                .padding(10)
                .overlay {
                    Circle().stroke(.gray, lineWidth: 1)
                }

        }
    }
}
