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
                                    .font(.system(size: 20, design: .serif))
                                    .lineSpacing(9)
                                    .padding(.top)
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
