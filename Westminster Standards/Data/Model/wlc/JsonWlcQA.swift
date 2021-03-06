//
//  WcfSection.swift
//  Westminster Standards
//
//  Created by Matt Robertson on 1/7/22.
//

import Foundation

struct JsonWlcQA: Decodable {
    var question: String
    var answer: String
    var proofs: [JsonWlcProofs]
}

struct JsonWlcProofs: Decodable {
    var letter: String
    var refs: [String]
}
