//
//  Models.swift
//  Catalog
//
//  Created by Amol Gundeti on 3/2/23.
//

import Foundation

//Struct for storing movie information
struct TmdbEntry: Codable, Identifiable {
    let popularity: Double?
    let voteCount: Int?
    let video: Bool?
    let posterPath: String?
    let id: Int?
    let adult: Bool?
    let backdropPath: String?
    let originalLanguage: String?
    let originalTitle: String?
    let genreIDS: [Int]?
    let title: String?
    let voteAverage: Double?
    let overview, releaseDate: String?
    let mediaType: String?
    var rating: String?

    enum CodingKeys: String, CodingKey {
        case popularity
        case voteCount = "vote_count"
        case video
        case posterPath = "poster_path"
        case id, adult
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIDS = "genre_ids"
        case title
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
        case mediaType = "media_type"
    }
}


//Struct for decoding API response
struct TmdbResponse: Codable{
    let page: Int
    let totalResults: Int?
    let totalPages: Int?
    let results: [TmdbEntry]

}


//Catalog class for persisting the user catalog
class Catalog: ObservableObject {
    @Published var results: [TmdbEntry] = []
    @Published var addedMovies: [Int: Int] = [:]
    let resultsSaveKey = "SavedResultsKey"
    let addedMoviesSaveKey = "SavedAddedMoviesKey"
    
    init(){
        if let data = UserDefaults.standard.data(forKey: resultsSaveKey){
            if let decoded = try? JSONDecoder().decode([TmdbEntry].self, from: data){
                self.results = decoded
            }
        }
        
        if let data = UserDefaults.standard.data(forKey: addedMoviesSaveKey){
            if let decoded = try? JSONDecoder().decode([Int:Int].self, from: data){
                self.addedMovies = decoded
            }
        }
        
        
    }
    
    
    func save(){
        if let encoded = try? JSONEncoder().encode(results){
            UserDefaults.standard.set(encoded, forKey: resultsSaveKey)
        }
        if let encoded = try? JSONEncoder().encode(addedMovies){
            UserDefaults.standard.set(encoded, forKey: addedMoviesSaveKey)
        }
    }
}

//Bookmark class for persisting bookmark data
class Bookmarks: ObservableObject {
    @Published var results: [TmdbEntry] = []
    @Published var bookmarkedMovies: [Int: Int] = [:]
    let bookmarkArraySaveKey = "bookmarkArraySaveKey"
    let bookmarksDictSaveKey = "BookmarkedId"
    
    init(){
        if let data = UserDefaults.standard.data(forKey: bookmarkArraySaveKey){
            if let decoded = try? JSONDecoder().decode([TmdbEntry].self, from: data){
                self.results = decoded
                return
            }
        }
        
        if let data = UserDefaults.standard.data(forKey: bookmarksDictSaveKey){
            if let decoded = try? JSONDecoder().decode([Int: Int].self, from: data){
                self.bookmarkedMovies = decoded
                return
            }
        }
    }
    
    
    func save(){
        if let encoded = try? JSONEncoder().encode(results){
            UserDefaults.standard.set(encoded, forKey: bookmarkArraySaveKey)
        }
        if let encoded = try? JSONEncoder().encode(bookmarkedMovies){
            UserDefaults.standard.set(encoded, forKey: bookmarksDictSaveKey)
        }
    }
}

//Observed results for storing TMDB search response
class ObservedResults: ObservableObject {
    @Published var results: [TmdbEntry] = []
}

//Display message for updating toast and managing visibility
class DisplayMessage: ObservableObject{
    @Published var msg: String = ""
    @Published var isShowingToast = false
}

//Class for tracking how many times app has been activated
class TrackOpenings: ObservableObject{
    @Published var openedCount: Int = 0
    let openingSaveKey = "OpeningObject"
    
    init(){
        if let data = UserDefaults.standard.data(forKey: openingSaveKey){
            if let decoded = try? JSONDecoder().decode(Int.self, from: data){
                self.openedCount = decoded
            }
        }
    }
    
    
    func save(){
        if let encoded = try? JSONEncoder().encode(openedCount){
            UserDefaults.standard.set(encoded, forKey: openingSaveKey)
        }

    }
}

class UserAccount: ObservableObject {
    @Published var firstName: String = ""
    @Published var email: String = ""
}
