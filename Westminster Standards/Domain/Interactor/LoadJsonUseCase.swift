//
//  LoadWcfUseCase.swift
//  Westminster Standards
//
//  Created by Matt Robertson on 1/7/22.
//

import Foundation

struct LoadJsonUseCase {

    func execute(filename: String) -> Data? {
        if let path = Bundle.main.path(forResource: filename, ofType: "json") {
          do {
              return try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
          } catch _ {
              return nil
          }
        }
        return nil
    }
}
