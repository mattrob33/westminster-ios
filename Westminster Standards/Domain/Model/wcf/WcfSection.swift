//
//  WcfSection.swift
//  Westminster Standards
//
//  Created by Matt Robertson on 1/7/22.
//

import Foundation

/// A section of the WCF.
struct WcfSection: Hashable, Equatable, Identifiable {
    
    let id = UUID()
    
    var text: String
    var proofs: [Proofs]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(text)
    }
    
    static func == (lhs: WcfSection, rhs: WcfSection) -> Bool {
        return lhs.text == rhs.text
    }
}
