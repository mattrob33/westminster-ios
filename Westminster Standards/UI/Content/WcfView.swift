//
//  ContentView.swift
//  Westminster Standards
//
//  Created by Matt Robertson on 1/7/22.
//

import SwiftUI

struct WcfView: View {
    
    @State var wcf: WCF

    @State private var currentChapter = 0
    @State private var recentChapter = 0

    @Binding var scrollPosition: Int
    @State private var scrollProxy: ScrollViewProxy? = nil
    
    @State private var proofRefs = ""
    @State private var showingProofsAlert = false

    @EnvironmentObject var settings: Settings
    @EnvironmentObject var theme: Theme

    var body: some View {
        ScrollView {
            ScrollViewReader { proxy in
                
                VStack(alignment: .leading) {
                    ForEach(wcf.chapters.indices) { i in
                        VStack(alignment: .leading) {
                            let chapter = wcf.chapters[i]
                            
                            Text("\(romanNumeral(i+1)). \(chapter.title)")
                                .font(.custom("EBGaramond-Medium", size: CGFloat(Double(settings.fontSize) * 1.1)))
                                .foregroundColor(theme.primaryTextColor)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.vertical)

                            ForEach(chapter.sections.indices) { j in
                                let section = chapter.sections[j]
                                Section(section: section)
                                    .environmentObject(theme)
                                ProofsView(proofs: section.proofs)
                                    .padding(.bottom, 24)
                            }
                        }
                        .padding(.bottom, 60)
                        .id(i)
                    }
                }
                .onAppear {
                    scrollProxy = proxy
                    proxy.scrollTo(scrollPosition, anchor: .top)
                }
            }
        }
        .padding(.leading).padding(.trailing)
        .background(theme.backgroundColor)
        .onChange(of: scrollPosition) { target in
            scrollProxy?.scrollTo(target, anchor: .top)
        }
        .alert(proofRefs, isPresented: $showingProofsAlert) {
            Button("Close") {
                showingProofsAlert = false
            }
        }
    }
}

struct Section: View {
    
    let section: WcfSection
    
    @EnvironmentObject var theme: Theme
    
    var body: some View {
        let parts = section.text.split(usingRegex: "\\[[a-z]\\]")
        
        var view = Text("")
        
        for k in parts.indices {
            let isFootnote = parts[k].matches("\\[[a-z]\\]")

            let fontSize = isFootnote ? 16 : 22
            let textColor = isFootnote ? theme.accentColor : theme.primaryTextColor

            let text = isFootnote
                ?
                parts[k].removeAll("[").removeAll("]")
                :
                parts[k]

            view = view + Text(text)
                .baselineOffset(isFootnote ? 8 : 0)
                .font(Font.custom("EBGaramond-Regular", size: CGFloat(fontSize)))
                .foregroundColor(textColor)
        }
        
        return view
            .lineSpacing(6)
            .frame(maxWidth: .infinity)
    }
}

private func romanNumeral(_ num: Int) -> String {
    let values: [Int] = [1, 4, 5, 9, 10, 40, 50]
    let symbols: [String] = ["I", "IV", "V", "IX", "X", "XL", "L"]
    var result = ""
    var remaining = num
    
    var index = values.count - 1
    while remaining > 0 {
        while remaining >= values[index] {
            result += symbols[index]
            remaining -= values[index]
        }
        index -= 1
    }
    
    return result
}


