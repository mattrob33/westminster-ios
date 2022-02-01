//
//  WscQA.swift
//  Westminster Standards
//
//  Created by Matt Robertson on 1/12/22.
//

import Foundation

struct WscQA: Hashable, Equatable {
    var question: String
    var answer: String
    var proofs: [Proofs]
}
