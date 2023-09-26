//
//  BaseViews.swift
//  Westminster Standards
//
//  Created by Matt Robertson on 9/25/23.
//

import SwiftUI

struct Title: View {
    
    let title: String
    
    init(_ title: String) {
        self.title = title
    }
    
    var body: some View {
        Text(title)
            .font(.custom("EBGaramond-Bold", size: 32))
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.top, 72)
    }
}

struct Question: View {
    
    let num: Int
    let question: String
    
    var body: some View {
        Text("Q\(num). \(question)")
            .font(.custom("EBGaramond-Bold", size: 20))
            .foregroundColor(Color(red: 0.83, green: 0.84, blue: 0.85))
            .lineSpacing(8)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 8)
    }
}

struct Answer: View {
    
    let answer: String
    
    init(_ answer: String) {
        self.answer = answer
    }
    
    var body: some View {
        let parts = answer.split(usingRegex: "\\[[a-z]\\]")
        
        var text = Text("")
        
        for part in parts {
            let isFootnote = part.matches("\\[[a-z]\\]")
            
            text = text + Text(
                isFootnote ?
                part.removeAll("[").removeAll("]")
                    :
                    part
            )
            .font(.custom("EBGaramond-Regular", size: isFootnote ? 16 : 20))
            .baselineOffset(isFootnote ? 6 : 0)
            .foregroundColor(isFootnote ? .gold : .text)
        }
        
        return text
            .lineSpacing(8)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 8)
    }
}
