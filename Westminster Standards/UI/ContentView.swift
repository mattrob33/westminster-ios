//
//  ContentView.swift
//  Westminster Standards
//
//  Created by Matt Robertson on 1/7/22.
//

import SwiftUI

struct ContentView: View {
     
    @State var content: Content

    @State private var isShowingSheet = false
    @State private var selectedTab = 0
    
    @State private var scrollPosition: Int = 0
    
    var body: some View {
        
        let loadWcfUseCase = LoadWcfUseCase()
        let wcf = loadWcfUseCase.execute()
        
        let loadWlcUseCase = LoadWlcUseCase()
        let wlc = loadWlcUseCase.execute()

        let loadWscUseCase = LoadWscUseCase()
        let wsc = loadWscUseCase.execute()

        if let wcf = wcf, let wlc = wlc, let wsc = wsc {
            
            let wcfView = WcfView(
                wcf: wcf,
                scrollPosition: $scrollPosition
            )
            
            let wlcView = WlcView(
                wlc: wlc,
                scrollPosition: $scrollPosition
            )
            
            let wscView = WscView(
                wsc: wsc,
                scrollPosition: $scrollPosition
            )
            
            ZStack(alignment: .bottom) {
                
                switch content {
                case .wcf:
                    wcfView
                case .wlc:
                    wlcView
                case .wsc:
                    wscView
                }
                
                HStack {
                    Spacer()
                    Image(systemName: "book")
                        .onTapGesture {
                            isShowingSheet = true
                            selectedTab = 1
                        }
                    Spacer()
                    Image(systemName: "magnifyingglass")
                    Spacer()
                    Image(systemName: "gearshape")
                    Spacer()
                }
                .padding(.top)
                .padding(.bottom)
                .background(Color.white)
            }
            .sheet(
                isPresented: $isShowingSheet,
                onDismiss: {
                    isShowingSheet = false
                },
                content: {
                    TableOfContentsView(
                        content: $content,
                        wcf: wcf,
                        wlc: wlc,
                        wsc: wsc,
                        recentWcfChapter: 0,
                        recentWlcQuestion: 0,
                        recentWscQuestion: 0,
                        onWcfChapterSelected: { chapter in
                            scrollPosition = chapter
                            isShowingSheet = false
                        },
                        onWlcQuestionSelected: { question in
                            scrollPosition = question
                            isShowingSheet = false
                        },
                        onWscQuestionSelected: { question in
                            scrollPosition = question
                            isShowingSheet = false
                        }
                    )
                }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(content: .wcf)
    }
}

enum Content {
    case wcf
    case wlc
    case wsc
}
