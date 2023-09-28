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
                            Text("\(i + 1).\(j + 1) (\(wcf.chapters[i].title))")
                                .font(.system(size: 18, weight: .bold))
                                .padding(.bottom, 2)
                            highlightSearchHits(matchedText: section.text, searchText: searchText, theme: theme)
                                .font(.system(size: 18))
                        }
                        .padding(.top)
                    }
                }
            }
        }
    }
}
