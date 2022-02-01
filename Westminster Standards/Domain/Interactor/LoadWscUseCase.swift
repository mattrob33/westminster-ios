//
//  LoadWscUseCase.swift
//  Westminster Standards
//
//  Created by Matt Robertson on 1/7/22.
//

import Foundation

/// Loads the WCF model.
struct LoadWscUseCase {

    private let loadJson = LoadJsonUseCase()

    func execute() -> WSC? {
        if let rawData = loadJson.execute(filename: "wsc") {
            return parseWsc(rawData: rawData)
        }
        return nil
    }

    private func parseWsc(rawData: Data) -> WSC? {
        let decoder = JSONDecoder()
        do {
            let jsonWsc = try decoder.decode(JsonWSC.self, from: rawData)
            return jsonWsc.toModel()
        }
        catch {
            print("WSC Error: \(error)")
            return nil
        }
    }
}

extension JsonWSC {
    
    func toModel() -> WSC {
        return WSC(questions: questions.map { $0.toModel() } )
    }
    
}

extension JsonWscQA {
    
    func toModel() -> WscQA {
        return WscQA(question: question, answer: answer, proofs: proofs.map { $0.toModel() } )
    }
    
}

extension JsonWscProofs {
    
    func toModel() -> Proofs {
        return Proofs(letter: letter, refs: refs)
    }
    
}

