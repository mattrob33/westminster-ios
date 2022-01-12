//
//  WcfSection.swift
//  Westminster Standards
//
//  Created by Matt Robertson on 1/7/22.
//

import Foundation

struct JsonWCF: Decodable {
    var chapters: [JsonWcfChapter]
}
