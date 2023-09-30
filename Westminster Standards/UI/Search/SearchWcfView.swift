//
//  SearchWcfView.swift
//  Westminster Standards
//
//  Created by Matt Robertson on 1/7/22.
//

import SwiftUI

struct SearchWcfView: View {

    var wcf: WCF
    @Binding var searchText: String

    @EnvironmentObject var theme: Theme
    
    init(_ wcf: WCF, search searchText: Binding<String>) {
        self.wcf = wcf
        self._searchText = searchText
    }
    
    var body: some View {
        VStack {
            ForEach(wcf.chapters.indices, id: \.self) { i in
                let chapter = wcf.chapters[i]
                
                ForEach(chapter.sections.indices, id: \.self) { j in
                    let section = chapter.sections[j]
                    
                    if section.text.localizedCaseInsensitiveContains(searchText) {
                        VStack(alignment: .leading) {
                            Hit(
                                chapter: i + 1,
                                section: j + 1,
                                title: wcf.chapters[i].title
                            )
                            
                            highlightSearchHits(
                                matchedText: section.text.replacingOccurrences(of: "\\[[0-9]+\\]", with: "", options: .regularExpression),
                                searchText: searchText,
                                theme: theme
                            )
                            .font(theme.bodyFont)
                            .foregroundColor(theme.secondaryTextColor)
                        }
                        .padding(.top)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func Hit(
        chapter: Int,
        section: Int,
        title: String
    ) -> some View {
        Text("\(chapter).\(section) - \(title)")
            .font(theme.headingFont)
            .foregroundColor(theme.primaryTextColor)
            .padding(.bottom, 2)
    }
}
