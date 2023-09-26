//
//  QA.swift
//  Westminster Standards
//
//  Created by Matt Robertson on 9/26/23.
//

import Foundation

struct QA: Hashable, Equatable {
    var question: String
    var answer: String
    var proofs: [Proofs]
}
