//
//  ContentView.swift
//  Westminster Standards
//
//  Created by Matt Robertson on 1/7/22.
//

import SwiftUI

struct WcfView: View {

    @State private var showingToc = false

    @State private var scrollPosition = 0

    var body: some View {
        
        let loadWcfUseCase = LoadWcfUseCase()
        let wcf = loadWcfUseCase.execute()
        
        let symbol: String = {
            if showingToc {
                return "▲"
            } else {
                return "▼"
            }
        }()

        if let wcf = wcf {
            
            VStack(alignment: .leading) {
                
                Text("\(wcf.title) \(symbol)")
                    .foregroundColor(Color.accentColor)
                    .font(.system(size: 18))
                    .padding(.top).padding(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.white)
                    .onTapGesture {
                        showingToc = !showingToc
                    }

                Divider()
                
                ZStack {
                    WcfTextView(wcf: wcf, scrollPosition: $scrollPosition)

                    if showingToc {
                        TableOfContentsView(
                            wcf: wcf,
                            onChapterSelected: { chapter in
                                scrollPosition = chapter
                                showingToc = false
                            }
                        )
                    }
                }
            }
        } else {
            Text("Unable to load WCF")
        }
    }
}

struct TableOfContentsView: View {

    private var wcf: WCF
    
    private var onChapterSelected: (Int) -> Void
    
    init(wcf: WCF, onChapterSelected: @escaping (Int) -> Void) {
        self.wcf = wcf
        self.onChapterSelected = onChapterSelected
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(wcf.chapters.indices) { i in
                    Text("\(i + 1). \(wcf.chapters[i].title)")
                        .font(.system(size: 20, design: .serif))
                        .padding(.top, 1)
                        .onTapGesture {
                            onChapterSelected(i)
                        }
                }
            }
            .padding(.leading)
            .padding(.trailing)
        }
        .background(Color.white)
    }
    
}

struct WcfTextView: View {

    var wcf: WCF

    @Binding var scrollPosition: Int
    
    @State private var scrollProxy: ScrollViewProxy? = nil

    var body: some View {
        ScrollView {
            ScrollViewReader { proxy in
                
                VStack(alignment: .leading) {
                    ForEach(wcf.chapters.indices) { i in
                        VStack(alignment: .leading) {
                            let chapter = wcf.chapters[i]
                            
                            Text("Chapter \(i + 1)")
                                .font(.system(size: 24, weight: .bold, design: .serif))
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.top)
                            
                            Text(chapter.title)
                                .font(.system(size: 22, weight: .bold, design: .serif))
                                .frame(maxWidth: .infinity, alignment: .center)
                            
                            ForEach(chapter.sections.indices) { j in
                                let section = chapter.sections[j]

                                Text("\(j + 1). \(section.text)")
                                    .font(.system(size: 18, design: .serif))
                                    .lineSpacing(9)
                                    .padding(.top)
                            }
                        }
                        .padding(.bottom, 100)
                        .id(i)
                    }
                }
                .onAppear {
                    scrollProxy = proxy
                }
            }
        }
        .padding(.leading)
        .padding(.trailing)
        .onChange(of: scrollPosition) { target in
            scrollProxy?.scrollTo(target, anchor: .top)
        }
    }
}

