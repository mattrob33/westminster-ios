//
//  WcfSection.swift
//  Westminster Standards
//
//  Created by Matt Robertson on 1/7/22.
//

import Foundation

/// The WCF.
struct WCF: Hashable, Equatable {
    let title = "Confession"
    let abbrv = "WCF"

    var chapters: [WcfChapter]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(abbrv)
    }
    
    static func == (lhs: WCF, rhs: WCF) -> Bool {
        return lhs.abbrv == rhs.abbrv
    }
}
