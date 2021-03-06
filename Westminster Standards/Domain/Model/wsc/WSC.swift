//
//  WSC.swift
//  Westminster Standards
//
//  Created by Matt Robertson on 1/12/22.
//

import Foundation

struct WSC: Hashable, Equatable {
    let title = "Westminster Shorter Catechism"
    let abbrv = "WSC"

    var questions: [WscQA]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(abbrv)
    }
    
    static func == (lhs: WSC, rhs: WSC) -> Bool {
        return lhs.abbrv == rhs.abbrv
    }
}
