//
//  WSC.swift
//  Westminster Standards
//
//  Created by Matt Robertson on 1/12/22.
//

import Foundation

struct WLC: Hashable, Equatable {
    let title = "Westminster Larger Catechism"
    let abbrv = "WLC"

    var questions: [WlcQA]

    func hash(into hasher: inout Hasher) {
        hasher.combine(abbrv)
    }

    static func == (lhs: WLC, rhs: WLC) -> Bool {
        return lhs.abbrv == rhs.abbrv
    }
}
