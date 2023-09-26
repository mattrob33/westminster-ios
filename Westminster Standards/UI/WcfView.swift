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
    
    private func romanNumeral(_ int: Int) -> String {
        switch (int) {
        case 1: return "I"
        case 2: return "II"
        case 3: return "III"
        case 4: return "IV"
        case 5: return "V"
        default: return ""
        }
    }

    var body: some View {
        ScrollView {
            ScrollViewReader { proxy in
                
                VStack(alignment: .leading) {
                    ForEach(wcf.chapters.indices) { i in
                        VStack(alignment: .leading) {
                            let chapter = wcf.chapters[i]
                            
                            Text("\(romanNumeral(i+1)). \(chapter.title)")
                                .font(.custom("EBGaramond-Medium", size: CGFloat(Double(settings.fontSize) * 1.1)))
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.top)
                            
                            ForEach(chapter.sections.indices) { j in
                                let section = chapter.sections[j]

                                let parts = section.text.split(usingRegex: "\\[[a-z]\\]")
    
                                    ForEach(parts.indices) { k in
                                        SectionPartText(text: parts[k], fontSize: 20, onTap: { letter in
                                            let letter = parts[k]
                                                .removeAll("[")
                                                .removeAll("]")
                                            let proofs = section.proofs.first(where: { $0.number == letter })
                                            proofRefs = proofs!.refs.joined(separator: "\n")
                                            showingProofsAlert = true
                                        })
                                        .font(.custom("EBGaramond-Regular", size: CGFloat(settings.fontSize)))
                                    }
                                .frame(maxWidth: .infinity)
                                
                                ProofsView(proofs: section.proofs)
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

struct SectionPartText: View {

    var text: String
    var fontSize: Int
    var onTap: (String) -> Void

    var body: some View {
        let isFootnote = text.matches("\\[[a-z]\\]")

        let fontSize = isFootnote ? fontSize - 2 : fontSize
        let textColor = isFootnote ? UIColor.blue : UIColor.textColor
 
        Text(text)
                .font(Font.custom("EBGaramond-Regular", size: CGFloat(fontSize)))
                .foregroundColor(Color(textColor))
                .onTapGesture {
                    if isFootnote {
                        let letter = text.removeAll("")
                        onTap(letter)
                    }
                }
    }
}

func buildSectionPartText(text: String, normalFontSize: Int, onTap: @escaping (String) -> Void) -> some View {

    let isFootnote = text.matches("\\[[a-z]\\]")

    let fontSize = isFootnote ? normalFontSize - 2 : normalFontSize
    let textColor = isFootnote ? UIColor.blue : UIColor.textColor

    return Text(text)
            .font(.custom("EBGaramond-Regular", size: CGFloat(fontSize)))
            .foregroundColor(Color(textColor))
            .onTapGesture {
                if isFootnote {
                    let letter = text.removeAll("")
                    onTap(letter)
                }
            }
}


