//
//  Settings.swift
//  Westminster Standards
//
//  Created by Matt Robertson on 1/15/22.
//

import Foundation
import Combine

class Settings: ObservableObject {
    
    @Published var fontSize: Int {
        didSet {
            UserDefaults.standard.set(fontSize, forKey: "fontSize")
        }
    }
    
    init() {
        UserDefaults.standard.register(defaults: ["fontSize": 20])
        self.fontSize = UserDefaults.standard.integer(forKey: "fontSize")
    }
}
