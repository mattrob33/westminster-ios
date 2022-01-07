//
//  WcfSection.swift
//  Westminster Standards
//
//  Created by Matt Robertson on 1/7/22.
//

import Foundation

/// A chapter of the WCF.
struct WcfChapter: Hashable, Equatable {
    var title: String
    var sections: [WcfSection]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
    
    static func == (lhs: WcfChapter, rhs: WcfChapter) -> Bool {
        return lhs.title == rhs.title
    }
}
