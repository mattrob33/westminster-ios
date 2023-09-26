//
//  BaseViews.swift
//  Westminster Standards
//
//  Created by Matt Robertson on 9/25/23.
//

import SwiftUI

struct Title: View {
    
    @EnvironmentObject var theme: Theme
    
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
    
    @EnvironmentObject var theme: Theme
    
    let num: Int
    let question: String
    
    var body: some View {
        Text("Q\(num). \(question)")
            .font(theme.headingFont)
            .foregroundColor(Color(red: 0.83, green: 0.84, blue: 0.85))
            .lineSpacing(8)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 8)
    }
}

struct Answer: View {
    
    @EnvironmentObject var theme: Theme
    
    let answer: String
    
    init(_ answer: String) {
        self.answer = answer
    }
    
    var body: some View {
        let parts = answer.split(usingRegex: "\\[[0-9]+\\]")
        
        var text = Text("")
        
        for part in parts {
            let isFootnote = part.matches("\\[[0-9]+\\]")
            
            text = text + Text(
                isFootnote ?
                part.removeAll("[").removeAll("]")
                    :
                    part
            )
            .font(isFootnote ? theme.footnoteFont : theme.bodyFont)
            .baselineOffset(isFootnote ? 6 : 0)
            .foregroundColor(isFootnote ? theme.accentColor : theme.primaryTextColor)
        }
        
        return text
            .lineSpacing(8)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 8)
    }
}
