//
//  WcfSection.swift
//  Westminster Standards
//
//  Created by Matt Robertson on 1/7/22.
//

import Foundation

struct JsonWscQA: Decodable {
    var question: String
    var answer: String
    var proofs: [JsonWscProofs]
}

struct JsonWscProofs: Decodable {
    var letter: String
    var refs: [String]
}
