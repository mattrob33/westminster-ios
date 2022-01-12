//
//  WcfSection.swift
//  Westminster Standards
//
//  Created by Matt Robertson on 1/7/22.
//

import Foundation

struct JsonWcfChapter: Decodable {
    var title: String
    var sections: [JsonWcfSection]
}
