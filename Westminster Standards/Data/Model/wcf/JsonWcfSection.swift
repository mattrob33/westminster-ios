//
//  WcfSection.swift
//  Westminster Standards
//
//  Created by Matt Robertson on 1/7/22.
//

import Foundation

struct JsonWcfSection: Decodable {
    var text: String
    var proofs: [JsonWcfProofs]
}

struct JsonWcfProofs: Decodable {
    var number: String
    var refs: [String]
}
