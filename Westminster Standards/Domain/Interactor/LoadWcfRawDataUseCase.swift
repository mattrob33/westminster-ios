//
//  LoadWcfUseCase.swift
//  Westminster Standards
//
//  Created by Matt Robertson on 1/7/22.
//

import Foundation


/// Loads the plain text for the WCF
struct LoadWcfRawDataUseCase {
    
    func execute() -> Data? {
        if let path = Bundle.main.path(forResource: "wcf", ofType: "json") {
          do {
              return try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
          } catch _ {
            // Handle error here
          }
        }
        return nil
    }
}
