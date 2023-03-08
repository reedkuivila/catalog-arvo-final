////
////  TmdbRequest.swift
////  Catalog
////
////  Created by Amol Gundeti on 3/2/23.
////
//
//import Foundation
//
//
//class TmdbRequest: ObservableObject {
//    
//    @Published var results: [TmdbEntry] = []
//
//    let apiKey = "ccc1083f814b898f8cd1b7a97b5f9b1b"
//    
//    var searchTerm: String
////
////    init() {
////
////        let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&query=\(searchTerm)")!
////
////
////
////        let task = URLSession.shared.dataTask(with: url) { data, _, error in
////
////            guard let data = data, error == nil else {
////                return
////            }
////
////            let decoder = JSONDecoder()
////            decoder.keyDecodingStrategy = .convertFromSnakeCase
////            let results = try? decoder.decode([TmdbEntry].self, from: data)
////            self.results = results!
////
//////            DispatchQueue.main.async {
//////                if let issues = issues {
//////                    self.openIssues = issues.filter({ $0.state == "open" })
//////                    print(self.openIssues)
//////                    self.closedIssues = issues.filter({ $0.state == "closed" })
//////                }
//////            }
////        }
////        task.resume()
////    }
//    
//    static func fetchMovies(searchTerm: String, completion: @escaping (TmdbResponse?, Error?) -> Void) {
//        
//        let searchTermURL = searchTerm.replacingOccurrences(of: " ", with: "+")
//        
//        
//        let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=\ccc1083f814b898f8cd1b7a97b5f9b1b&query=\(searchTermURL)")
//
//        let task = URLSession.shared.dataTask(with: url) { data, _, error in
//            
//            guard let data = data, error == nil else {
//                DispatchQueue.main.async { completion(nil, error) }
//                return
//            }
//            
//            do{
//                let decoder = JSONDecoder()
//                decoder.keyDecodingStrategy = .convertFromSnakeCase
//                let issues = try decoder.decode(TmdbResponse.self, from: data)
////                print("DEBUG ------> fetched new movies:", issues)
//                DispatchQueue.main.async { completion(issues, nil) }
//            } catch(let parsingError) {
//                DispatchQueue.main.async { completion(nil, parsingError) }
//            }
//        }
//        
//        task.resume()
//    }
//}
