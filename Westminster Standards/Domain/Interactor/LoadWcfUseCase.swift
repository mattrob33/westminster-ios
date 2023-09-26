//
//  LoadWcfUseCase.swift
//  Westminster Standards
//
//  Created by Matt Robertson on 1/7/22.
//

import Foundation

/// Loads the WCF model.
struct LoadWcfUseCase {
    
    private let loadJson = LoadJsonUseCase()

    func execute() -> WCF? {
        if let rawData = loadJson.execute(filename: "wcf") {
            return parseWcf(rawData: rawData)
        }
        return nil
    }

    private func parseWcf(rawData: Data) -> WCF? {
        let decoder = JSONDecoder()
        do {
            let jsonWcf = try decoder.decode(JsonWCF.self, from: rawData)
            return jsonWcf.toModel()
        }
        catch {
            print("WCF Error: \(error)")
            return nil
        }
    }
}

extension JsonWCF {
    
    func toModel() -> WCF {
        return WCF(chapters: chapters.map { $0.toModel() } )
    }
    
}

extension JsonWcfChapter {
    
    func toModel() -> WcfChapter {
        return WcfChapter(title: title, sections: sections.map { $0.toModel() })
    }
    
}

extension JsonWcfSection {
    
    func toModel() -> WcfSection {
        return WcfSection(text: text, proofs: proofs.map { $0.toModel() })
    }
    
}

extension JsonWcfProofs {
    
    func toModel() -> Proofs {
        return Proofs(number: letter, refs: refs)
    }
    
}
