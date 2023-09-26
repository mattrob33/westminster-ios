//
//  JsonQA.swift
//  Westminster Standards
//
//  Created by Matt Robertson on 9/26/23.
//

import Foundation

struct JsonQA: Decodable {
    var question: String
    var answer: String
    var proofs: [JsonProofs]
}

struct JsonProofs: Decodable {
    var number: String
    var refs: [String]
}
