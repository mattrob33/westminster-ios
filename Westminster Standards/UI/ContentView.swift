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
    
    @State var sheet: Sheet = .content

    @EnvironmentObject var settings: Settings

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
                scrollPosition: $contentLocation.location
            )
            .environmentObject(settings)
            
            let wlcView = CatechismView(
                catechism: wlc,
                scrollPosition: $contentLocation.location
            )
            .environmentObject(settings)
            
            let wscView = CatechismView(
                catechism: wsc,
                scrollPosition: $contentLocation.location
            )
            .environmentObject(settings)
            
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
            .environmentObject(settings)
            
            let settingsView = SettingsView(
                fontSize: settings.fontSize
            ).environmentObject(settings)
            
            ZStack(alignment: .bottom) {
                
                switch contentLocation.content {
                case .wcf:
                    wcfView
                case .wlc:
                    wlcView
                case .wsc:
                    wscView
                }
                
                VStack {
                    Divider()
                    
                    HStack {
                        Spacer()
                        
                        VStack {
                            Image(systemName: "book")
                                .resizable()
                                .foregroundColor(.gray)
                                .frame(width: 24.0, height: 24.0)
                                .onTapGesture {
                                    sheet = .content
                                    isShowingSheet = true
                                }
                            
                            Text("Contents")
                                .font(.system(size: 10))
                                .foregroundColor(.gray)
                                .padding(.top, 0.2)
                        }
                        
                        Spacer()
                        Spacer()
                        
                        VStack {
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .foregroundColor(.gray)
                                .frame(width: 24.0, height: 24.0)
                                .onTapGesture {
                                    sheet = .search
                                    isShowingSheet = true
                                }
                            
                            Text("Search")
                                .font(.system(size: 10))
                                .foregroundColor(.gray)
                                .padding(.top, 0.2)
                        }
                        
                        Spacer()
                        Spacer()
                        
                        VStack {
                            Image(systemName: "gearshape")
                                .resizable()
                                .foregroundColor(.gray)
                                .frame(width: 24.0, height: 24.0)
                                .onTapGesture {
                                    sheet = .settings
                                    isShowingSheet = true
                                }
                            
                            Text("Settings")
                                .font(.system(size: 10))
                                .foregroundColor(.gray)
                                .padding(.top, 0.2)
                        }
                        
                        Spacer()
                    }
                    .padding(.top, 4)
                }
                .background(Color(red: 0.13, green: 0.13, blue: 0.13))
            }
            .sheet(
                isPresented: $isShowingSheet,
                onDismiss: {
                    isShowingSheet = false
                },
                content: {
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
                        settingsView
                    }
                }
            )
        } else {
            Text("No data")
        }
    }
}

enum Sheet {
    case content
    case search
    case settings
}

enum WestminsterContent {
    case wcf
    case wlc
    case wsc
}

struct ContentLocation {
    var content: WestminsterContent
    var location: Int
}
