//
//  LoadWscUseCase.swift
//  Westminster Standards
//
//  Created by Matt Robertson on 1/7/22.
//

import Foundation

/// Loads the WCF model.
struct LoadWlcUseCase {

    private let loadJson = LoadJsonUseCase()

    func execute() -> WLC? {
        if let rawData = loadJson.execute(filename: "wlc") {
            return parseWlc(rawData: rawData)
        }
        return nil
    }

    private func parseWlc(rawData: Data) -> WLC? {
        let decoder = JSONDecoder()
        do {
            let jsonWlc = try decoder.decode(JsonCatechism.self, from: rawData)
            return jsonWlc.toModel()
        }
        catch {
            print("WLC Error: \(error)")
            return nil
        }
    }
}

fileprivate extension JsonCatechism {
    
    func toModel() -> WLC {
        return WLC(questions: questions.map { $0.toModel() } )
    }
    
}
