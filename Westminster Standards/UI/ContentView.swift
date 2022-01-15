//
//  ContentView.swift
//  Westminster Standards
//
//  Created by Matt Robertson on 1/7/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var contentLocation: ContentLocation

    @State private var isShowingSheet = false

    @State private var recentWcfChapter: Int = 0
    @State private var recentWlcQuestion: Int = 0
    @State private var recentWscQuestion: Int = 0

    var body: some View {
        
        var sheet: Sheet? = nil
        
        let loadWcfUseCase = LoadWcfUseCase()
        let wcf = loadWcfUseCase.execute()
        
        let loadWlcUseCase = LoadWlcUseCase()
        let wlc = loadWlcUseCase.execute()

        let loadWscUseCase = LoadWscUseCase()
        let wsc = loadWscUseCase.execute()

        if let wcf = wcf, let wlc = wlc, let wsc = wsc {
            
            let wcfView = WcfView(
                wcf: wcf,
                scrollPosition: $contentLocation.location
            )
            
            let wlcView = WlcView(
                wlc: wlc,
                scrollPosition: $contentLocation.location
            )
            
            let wscView = WscView(
                wsc: wsc,
                scrollPosition: $contentLocation.location
            )
            
            let tocView = TableOfContentsView(
                content: contentLocation.content,
                wcf: wcf,
                wlc: wlc,
                wsc: wsc,
                recentWcfChapter: recentWcfChapter,
                recentWlcQuestion: recentWlcQuestion,
                recentWscQuestion: recentWscQuestion,
                onItemSelected: { newContent, item in
                    contentLocation = ContentLocation(content: newContent, location: item)
                    
                    switch (newContent) {
                    case .wcf:
                        recentWcfChapter = item
                    case .wlc:
                        recentWlcQuestion = item
                    case .wsc:
                        recentWscQuestion = item
                    }
                    
                    isShowingSheet = false
                },
                onTapDone: {
                    isShowingSheet = false
                }
            )
            
            ZStack(alignment: .bottom) {
                
                switch contentLocation.content {
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
                            tocView
                            
                        case .search:
                            SearchView(
                                wcf: wcf,
                                wlc: wlc,
                                wsc: wsc,
                                onTapDone: {
                                    isShowingSheet = false
                                }
                            )
                            
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

struct ContentLocation {
    var content: Content
    var location: Int
}
