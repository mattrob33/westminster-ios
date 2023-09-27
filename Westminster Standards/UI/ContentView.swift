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
            
            let searchView = SearchView(
                wcf: wcf,
                wlc: wlc,
                wsc: wsc
            )
            .background(theme.backgroundColor)
            .environmentObject(settings)
            .environmentObject(theme)
            
            TabView {
                wcfView
                    .tabItem {
                        Label("WCF", systemImage: "book")
                    }
                
                wlcView
                    .tabItem {
                        Label("WLC", systemImage: "questionmark.square")
                    }
                
                wscView
                    .tabItem {
                        Label("WSC", systemImage: "questionmark.app.dashed")
                    }
                
                searchView
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
            }
            .toolbarBackground(theme.backgroundAccentColor, for: .tabBar)
            .accentColor(theme.accentColor)
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
