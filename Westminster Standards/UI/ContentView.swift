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
    @State var sheet: Sheet? = nil

    @State private var scrollPosition: Int = 0
    
    @State private var recentWcfChapter: Int = 0
    @State private var recentWlcQuestion: Int = 0
    @State private var recentWscQuestion: Int = 0

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
                            sheet = .content
                            isShowingSheet = true
                        }
                    Spacer()
                    Image(systemName: "magnifyingglass")
                        .onTapGesture {
                            sheet = .search
                            isShowingSheet = true
                        }
                    Spacer()
                    Image(systemName: "gearshape")
                        .onTapGesture {
                            sheet = .settings
                            isShowingSheet = true
                        }
                    Spacer()
                }
                .padding(.top)
                .padding(.bottom)
                .background(.background)
            }
            .sheet(
                isPresented: $isShowingSheet,
                onDismiss: {
                    isShowingSheet = false
                },
                content: {
                    if let sheet = sheet {
                        switch (sheet) {
                        case .content:
                            TableOfContentsView(
                                content: $content,
                                wcf: wcf,
                                wlc: wlc,
                                wsc: wsc,
                                recentWcfChapter: recentWcfChapter,
                                recentWlcQuestion: recentWlcQuestion,
                                recentWscQuestion: recentWscQuestion,
                                onItemSelected: { item in
                                    scrollPosition = item
                                    isShowingSheet = false
                                    
                                    switch (content) {
                                    case .wcf:
                                        recentWcfChapter = item
                                    case .wlc:
                                        recentWlcQuestion = item
                                    case .wsc:
                                        recentWscQuestion = item
                                    }
                                }
                            )
                            
                        case .search:
                            SearchView(wcf: wcf, wlc: wlc, wsc: wsc)
                            
                        case .settings:
                            Text("Settings Screen")
                        }
                    }
                }
            )
        }
    }
}

enum Sheet {
    case content
    case search
    case settings
}

enum Content {
    case wcf
    case wlc
    case wsc
}
