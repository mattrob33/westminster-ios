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

    @EnvironmentObject var settings: Settings

    var body: some View {
        ScrollView {
            ScrollViewReader { proxy in
                
                VStack(alignment: .leading) {
                    ForEach(wcf.chapters.indices) { i in
                        VStack(alignment: .leading) {
                            let chapter = wcf.chapters[i]
                            
                            Text("Chapter \(i + 1)")
                                .font(.system(size: CGFloat(Double(settings.fontSize) * 1.2), weight: .bold, design: .serif))
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.top)
                            
                            Text(chapter.title)
                                .font(.system(size: CGFloat(Double(settings.fontSize) * 1.1), weight: .bold, design: .serif))
                                .frame(maxWidth: .infinity, alignment: .center)
                            
                            ForEach(chapter.sections.indices) { j in
                                let section = chapter.sections[j]
                                
                                buildSectionText(num: j + 1, section: section, normalFontSize: settings.fontSize)
                                    .font(.system(size: CGFloat(settings.fontSize), design: .serif))
                                    .lineSpacing(9)
                                    .padding(.top)
                                
                                ForEach(section.proofs.indices) { k in
                                    let proofs = section.proofs[k]
                                    buildProofsText(proofs)
                                }
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
    }
}

func buildSectionText(num: Int, section: WcfSection, normalFontSize: Int) -> Text {
    
    let parts = section.text.split(usingRegex: "\\[[a-z]\\]")
    
    var tb = Text("\(num). ")
    
    for i in parts.indices {
        tb = tb + buildSectionPartText(text: parts[i], normalFontSize: normalFontSize)
    }
    
    return tb
}

func buildSectionPartText(text: String, normalFontSize: Int) -> Text {
    
    let isFootnote = text.matches("\\[[a-z]\\]")

    let fontSize = isFootnote ? normalFontSize - 2 : normalFontSize
    let textColor = isFootnote ? UIColor.blue : UIColor.textColor
    
    return Text(text)
            .font(.system(size: CGFloat(fontSize), design: .serif))
            .foregroundColor(Color(textColor))
}

func buildProofsText(_ proofs: Proofs) -> Text {
    
    let text = proofs.refs.joined(separator: "; ")
    
    return Text("[\(proofs.letter)] \(text)")
}

extension String {
    func split(usingRegex pattern: String) -> [String] {
        let regex = try! NSRegularExpression(pattern: pattern)
        let matches = regex.matches(in: self, range: NSRange(startIndex..., in: self))
        let splits = [startIndex]
            + matches
                .map { Range($0.range, in: self)! }
                .flatMap { [ $0.lowerBound, $0.upperBound ] }
            + [endIndex]

        return zip(splits, splits.dropFirst())
            .map { String(self[$0 ..< $1])}
    }
    
    func matches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
}

extension UIColor{
    static var textColor: UIColor{
        return UIColor.init { (trait) -> UIColor in
            return trait.userInterfaceStyle == .dark ? UIColor.white : UIColor.black
        }
    }
}
