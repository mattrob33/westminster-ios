//
//  WcfSection.swift
//  Westminster Standards
//
//  Created by Matt Robertson on 1/7/22.
//

import Foundation

struct JsonWLC: Decodable {
    var questions: [JsonWlcQA]
}
