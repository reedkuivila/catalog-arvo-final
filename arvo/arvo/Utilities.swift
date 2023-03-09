//
//  Utilities.swift
//  Catalog
//
//  Created by Amol Gundeti on 3/6/23.
//

import Foundation
import SwiftUI

//Attribution: Module 7 Starter Code
func formatDate(date: String, mode: Int) -> String? {
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = "yyyy-MM-dd"

    let dateFormatterPrint = DateFormatter()
    
    if mode == 0{
    dateFormatterPrint.dateFormat = "yyyy"
    }else{
        dateFormatterPrint.dateFormat = "MMM d, yyyy"
    }
    
    if let curdate = dateFormatterGet.date(from: date) {
        return dateFormatterPrint.string(from: curdate)
    } else {
       return nil
    }
}

//Blur effect for detail view
//https://medium.com/@edwurtle/blur-effect-inside-swiftui-a2e12e61e750

struct Blur: UIViewRepresentable {
    var style: UIBlurEffect.Style
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}

//Enum for enconding genres
func genreIDToString( _ genreID: Int) -> String{
    
    switch genreID {
        case 28:
            return "Action"
        case 12:
            return "Adventure"
        case 16:
            return "Animation"
        case 35:
            return "Comedy"
        case 80:
            return "Crime"
        case 99:
            return "Documentary"
        case 18:
            return "Drama"
        case 10751:
            return "Family"
        case 14:
            return "Fantasy"
        case 36:
            return "History"
        case 27:
            return "Horror"
        case 10402:
            return "Music"
        case 9648:
            return "Mystery"
        case 10749:
            return "Romance"
        case 878:
            return "Science Fiction"
        case 10770:
            return "TV Movie"
        case 53:
            return "Thriller"
        case 10752:
            return "War"
        case 37:
            return "Western"
        default:
            return "Unknown"
        }
}
