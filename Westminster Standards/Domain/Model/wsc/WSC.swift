//
//  WSC.swift
//  Westminster Standards
//
//  Created by Matt Robertson on 1/12/22.
//

import Foundation

struct WSC: Catechism, Hashable, Equatable {
    
    let id = UUID()
    
    let title = "Shorter Catechism"
    let abbrv = "WSC"

    var questions: [QA]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(abbrv)
    }
    
    static func == (lhs: WSC, rhs: WSC) -> Bool {
        return lhs.abbrv == rhs.abbrv
    }
}
