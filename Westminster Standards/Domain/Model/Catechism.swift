//
//  Catechism.swift
//  Westminster Standards
//
//  Created by Matt Robertson on 9/26/23.
//

import Foundation

protocol Catechism: Identifiable {
    var title: String { get }
    var abbrv: String { get }
    var questions: [QA] { get }
}
