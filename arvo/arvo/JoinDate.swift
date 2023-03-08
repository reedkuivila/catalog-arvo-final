//
//  JoinDate.swift
//  arvo
//
//  Created by reed kuivila on 3/8/23.
//

import Foundation

struct Event: Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var dateEvent: Date
    var dateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, dd 'of' MMMM"
        return formatter.string(from: dateEvent)
    }
    
}

extension Event: Equatable, Hashable {}
