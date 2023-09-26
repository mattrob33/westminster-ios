//
//  JsonCatechism.swift
//  Westminster Standards
//
//  Created by Matt Robertson on 9/26/23.
//

import Foundation

struct JsonCatechism: Decodable {
    var questions: [JsonQA]
}
