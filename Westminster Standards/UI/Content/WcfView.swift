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
    
    @State private var showTopBar = true
    @State private var showBottomBar = true
    
    @State private var showPicker = false

    @Binding var scrollPosition: Int
    @State private var scrollProxy: ScrollViewProxy? = nil

    @EnvironmentObject var settings: Settings
    @EnvironmentObject var theme: Theme

    var body: some View {
        ZStack {
            ScrollView {
                ScrollViewReader { proxy in
                    
                    VStack(alignment: .leading) {
                        
                        Spacer(minLength: 70)
                            .id(0)
                        
                        ForEach(wcf.chapters.indices) { i in
                            VStack(alignment: .leading) {
                                let chapter = wcf.chapters[i]

                                Text("\(romanNumeral(i+1)). \(chapter.title)")
                                    .font(theme.headingFont)
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
                            .id(i + 1)
                        }
                    }
                    .onAppear {
                        scrollProxy = proxy
                        proxy.scrollTo(scrollPosition, anchor: .top)
                    }
                }
            }
            .padding(.top, 20)
            .padding(.leading)
            .padding(.trailing)
            .onTapGesture {
                withAnimation {
                    showTopBar.toggle()
                    showBottomBar.toggle()
                }
            }
            .toolbar(showBottomBar ? .visible : .hidden, for: .tabBar)
            .statusBarHidden(showBottomBar ? false : true)
            
            if showPicker {
                TocPageView(
                    items: wcf.chapters.map { $0.title },
                    recentItem: recentChapter,
                    onItemSelected: { num in
                        scrollPosition = num + 1
                        showPicker = false
                        withAnimation {
                            showTopBar = false
                            showBottomBar = false
                        }
                    }
                )
                .padding(.top, 50)
            }
        }
        .background(theme.backgroundColor)
        .edgesIgnoringSafeArea(.all)
        .onChange(of: scrollPosition) { target in
            scrollProxy?.scrollTo(target, anchor: .top)
        }
        .overlay(alignment: .top) {
            if showTopBar {
                TopBar(
                    title: wcf.title,
                    isExpanded: showPicker,
                    onTap: {
                        showPicker.toggle()
                        showBottomBar = !showPicker
                    }
                )
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

            let textColor = isFootnote ? theme.accentColor : theme.secondaryTextColor

            let text = isFootnote
                ?
                parts[k].removeAll("[").removeAll("]")
                :
                parts[k]

            view = view + Text(text)
                .baselineOffset(isFootnote ? 8 : 0)
                .font(isFootnote ? theme.footnoteFont : theme.bodyFont)
                .foregroundColor(textColor)
        }
        
        return view
            .lineSpacing(10)
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


