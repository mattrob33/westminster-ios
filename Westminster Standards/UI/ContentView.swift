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
    
    @State var sheet: Sheet = .search

    @EnvironmentObject var settings: Settings
    @EnvironmentObject var theme: Theme

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
            .environmentObject(theme)
            
            let wlcView = CatechismView(
                catechism: wlc,
                scrollPosition: $contentLocation.location
            )
            .environmentObject(settings)
            .environmentObject(theme)
            
            let wscView = CatechismView(
                catechism: wsc,
                scrollPosition: $contentLocation.location
            )
            .environmentObject(settings)
            .environmentObject(theme)
            
//            let tocView = TableOfContentsView(
//                content: contentLocation.content,
//                wcf: wcf,
//                wlc: wlc,
//                wsc: wsc,
//                recentWcfChapter: recentWcfChapter,
//                recentWlcQuestion: recentWlcQuestion,
//                recentWscQuestion: recentWscQuestion,
//                onItemSelected: { newContent, item in
//                    contentLocation = ContentLocation(content: newContent, location: item)
//                    
//                    switch (newContent) {
//                    case .wcf:
//                        recentWcfChapter = item
//                    case .wlc:
//                        recentWlcQuestion = item
//                    case .wsc:
//                        recentWscQuestion = item
//                    }
//                    
//                    isShowingSheet = false
//                },
//                onTapDone: {
//                    isShowingSheet = false
//                }
//            )
//            .environmentObject(settings)
//            .environmentObject(theme)
            
            let settingsView = SettingsView(
                fontSize: settings.fontSize
            )
            .environmentObject(settings)
            .environmentObject(theme)
            
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

                        tabBarItem(
                            label: "WCF",
                            imageName: "book",
                            onTap: {
                                contentLocation = ContentLocation(content: .wcf, location: recentWcfChapter)
                            }
                        )
                        
                        Spacer()
                        Spacer()
                        
                        tabBarItem(
                            label: "WLC",
                            imageName: "questionmark.square",
                            onTap: {
                                contentLocation = ContentLocation(content: .wlc, location: recentWlcQuestion)
                            }
                        )
                        
                        Spacer()
                        Spacer()
                        
                        tabBarItem(
                            label: "WSC",
                            imageName: "questionmark.app.dashed",
                            onTap: {
                                contentLocation = ContentLocation(content: .wsc, location: recentWscQuestion)
                            }
                        )
                        
                        Spacer()
                        Spacer()
                        
                        tabBarItem(
                            label: "Search",
                            imageName: "magnifyingglass",
                            onTap: {
                                sheet = .search
                                isShowingSheet = true
                            }
                        )
                        
                        Spacer()
                        Spacer()
                        
                        tabBarItem(
                            label: "Settings",
                            imageName: "gearshape",
                            onTap: {
                                sheet = .settings
                                isShowingSheet = true
                            }
                        )
                        
                        Spacer()
                    }
                    .padding(.top, 4)
                }
                .background(theme.backgroundAccentColor)
            }
            .sheet(
                isPresented: $isShowingSheet,
                onDismiss: {
                    isShowingSheet = false
                },
                content: {
                    switch (sheet) {
//                    case .content:
//                        tocView
                        
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
            Text("")
        }
    }

    @ViewBuilder
    private func tabBarItem(
        label: String,
        imageName: String,
        onTap: @escaping () -> ()
    ) -> some View {
        VStack {
            Image(systemName: imageName)
                .resizable()
                .foregroundColor(theme.subduedIconColor)
                .frame(width: 24.0, height: 24.0)

            Text(label)
                .font(.system(size: 10))
                .foregroundColor(theme.subduedIconColor)
                .padding(.top, 0.2)
        }
        .onTapGesture(perform: onTap)
    }
}

enum Sheet {
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
