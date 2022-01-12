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
            let jsonWlc = try decoder.decode(JsonWLC.self, from: rawData)
            return jsonWlc.toModel()
        }
        catch {
            return nil
        }
    }
}

extension JsonWLC {
    
    func toModel() -> WLC {
        return WLC(questions: questions.map { $0.toModel() } )
    }
    
}

extension JsonWlcQA {
    
    func toModel() -> WlcQA {
        return WlcQA(question: question, answer: answer)
    }
    
}
