//
//  Proofs.swift
//  Westminster Standards
//
//  Created by Matt Robertson on 1/31/22.
//

import Foundation

struct Proofs: Hashable, Equatable {
    var letter: String
    var refs: [String]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(refs)
    }
    
    static func == (lhs: Proofs, rhs: Proofs) -> Bool {
        if lhs.letter != rhs.letter { return false }
        if lhs.refs.count != rhs.refs.count { return false }

        for i in lhs.refs.indices {
            if lhs.refs[i] != rhs.refs[i] { return false }
        }
        
        return true
    }
}
