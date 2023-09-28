//
//  SearchView.swift
//  Westminster Standards
//
//  Created by Matt Robertson on 1/7/22.
//

import SwiftUI

struct SearchView: View {

    var wcf: WCF
    var wlc: WLC
    var wsc: WSC

    @EnvironmentObject var theme: Theme

    @State private var content: WestminsterContent = WestminsterContent.wcf
    @State private var searchText : String = ""

    var body: some View {
        
        VStack {
            
            HStack {
                SearchBar(text: $searchText)
                Text("Done")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(theme.accentColor)
                    .onTapGesture {
                        UIApplication.shared.endEditing()
                    }
            }
            .padding(.leading).padding(.trailing)
            
            Picker("Content", selection: $content) {
                Text("Confession").tag(WestminsterContent.wcf)
                Text("Larger").tag(WestminsterContent.wlc)
                Text("Shorter").tag(WestminsterContent.wsc)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.leading).padding(.trailing)
        
            SearchResultsView(
                content: $content,
                searchText: $searchText,
                wcf: wcf,
                wlc: wlc,
                wsc: wsc
            )
            .environmentObject(theme)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct SearchResultsView: View {
    
    @EnvironmentObject var theme: Theme
    
    @Binding var content: WestminsterContent
    @Binding var searchText: String
    
    var wcf: WCF
    var wlc: WLC
    var wsc: WSC

    var body: some View {
        ScrollView {
            ScrollViewReader { proxy in
                VStack {
                    switch (content) {
                    case .wcf:
                        SearchWcfView(wcf, search: $searchText)

                    case .wlc:
                        SearchCatechismView(wlc, search: $searchText)
                        
                    case .wsc:
                        SearchCatechismView(wsc, search: $searchText)
                    }
                }
                .onChange(of: content) { content in
                    proxy.scrollTo(0, anchor: .top)
                }
            }
            
        }
        .padding(.horizontal)
    }

}

func highlightSearchHits(matchedText: String, searchText: String, theme: Theme) -> Text {
    
    let sections = matchedText.components(separatedBy: searchText)
    
    var compositeText = Text("")
    
    for i in sections.indices {
        
        compositeText = compositeText + Text("\(sections[i])")

        if i < (sections.endIndex - 1) {
            compositeText = compositeText +
                Text(searchText)
                .foregroundColor(theme.accentColor)
                .underline(color: theme.accentColor)
        }
    }

    return compositeText
}
