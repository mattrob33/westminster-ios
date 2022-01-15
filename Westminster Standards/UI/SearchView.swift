//
//  ContentView.swift
//  Westminster Standards
//
//  Created by Matt Robertson on 1/7/22.
//

import SwiftUI

struct SearchView: View {

    var wcf: WCF
    var wlc: WLC
    var wsc: WSC

    var onTapDone: () -> Void

    @State private var content: Content = Content.wcf
    @State private var searchText : String = ""

    var body: some View {
        
        VStack {
            
            HStack {
                SearchBar(text: $searchText)
                Text("Done")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(Color.accentColor)
                    .onTapGesture {
                        onTapDone()
                    }
            }
            .padding(.leading).padding(.trailing)
            
            Picker("Content", selection: $content) {
                Text("Confession").tag(Content.wcf)
                Text("Larger").tag(Content.wlc)
                Text("Shorter").tag(Content.wsc)
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
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct SearchBar: UIViewRepresentable {

    @Binding var text: String

    class Coordinator: NSObject, UISearchBarDelegate {

        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
    }

    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text)
    }

    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle = .minimal
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
}

struct SearchResultsView: View {
    
    @Binding var content: Content
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
                        ForEach(wcf.chapters.indices, id: \.self) { i in
                            let chapter = wcf.chapters[i]
                            
                            ForEach(chapter.sections.indices, id: \.self) { j in
                                let section = chapter.sections[j]
                                
                                if section.text.localizedCaseInsensitiveContains(searchText) {
                                    VStack(alignment: .leading) {
                                        Text("\(i + 1).\(j + 1) (\(wcf.chapters[i].title))")
                                            .font(.system(size: 18, weight: .bold))
                                            .padding(.bottom, 2)
                                        highlightSearchHits(matchedText: section.text, searchText: searchText)
                                            .font(.system(size: 18))
                                    }
                                    .padding(.top)
                                }
                            }
                        }
                    
                    case .wlc:
                        ForEach(wlc.questions.indices, id: \.self) { i in
                            let question = wlc.questions[i].question
                            let answer = wlc.questions[i].answer
                            
                            let matchesQuestion = question.localizedCaseInsensitiveContains(searchText)
                            let matchesAnswer = answer.localizedCaseInsensitiveContains(searchText)

                            if matchesQuestion || matchesAnswer {
                                VStack(alignment: .leading) {
                                    Group {
                                        Text("Q\(i + 1). ") + highlightSearchHits(matchedText: question, searchText: searchText)
                                    }
                                    .font(.system(size: 18, weight: .bold))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    Group {
                                        Text("A. ") + highlightSearchHits(matchedText: answer, searchText: searchText)
                                    }
                                    .font(.system(size: 18))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top)
                            }
                        }
                    
                    case .wsc:
                        ForEach(wsc.questions.indices, id: \.self) { i in
                            let question = wsc.questions[i].question
                            let answer = wsc.questions[i].answer
                            
                            let matchesQuestion = question.localizedCaseInsensitiveContains(searchText)
                            let matchesAnswer = answer.localizedCaseInsensitiveContains(searchText)

                            if matchesQuestion || matchesAnswer {
                                VStack(alignment: .leading) {
                                    Group {
                                        Text("Q\(i + 1). ") + highlightSearchHits(matchedText: question, searchText: searchText)
                                    }
                                    .font(.system(size: 18, weight: .bold))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    Group {
                                        Text("A. ") + highlightSearchHits(matchedText: answer, searchText: searchText)
                                    }
                                    .font(.system(size: 18))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top)
                            }
                        }
                    }
                }
                .onChange(of: content) { content in
                    proxy.scrollTo(0, anchor: .top)
                }
            }
            
        }
        .padding(.leading)
        .padding(.trailing)
    }

    private func highlightSearchHits(matchedText: String, searchText: String) -> Text {
        
        let sections = matchedText.components(separatedBy: searchText)
        
        var compositeText = Text("")
        
        for i in sections.indices {
            compositeText = compositeText + Text("\(sections[i])")
            if i < (sections.endIndex - 1) {
                compositeText = compositeText + Text(searchText).foregroundColor(Color.red).underline(color: .red)
            }
        }

        return compositeText
    }
}
