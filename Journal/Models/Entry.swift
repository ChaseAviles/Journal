//
//  Entry.swift
//  Journal
//
//  Created by Johnathan Aviles on 1/11/21.
//

import Foundation

class Entry: Codable {
    var title: String
    var body: String
    let timestamp: Date
    
    init(title: String, body: String, timestamp: Date = Date()){
        self.title = title
        self.body = body
        self.timestamp = timestamp
        
    }
}

extension Entry: Equatable {
    static func == (lhs: Entry, rhs: Entry) -> Bool {
        return lhs.title == rhs.title && lhs.body == rhs.body && lhs.timestamp == rhs.timestamp
    }
}
