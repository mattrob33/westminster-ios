//
//  ContentView.swift
//  Westminster Standards
//
//  Created by Matt Robertson on 1/7/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            WcfView()
                .tabItem {
                    Image(systemName: "book")
                }
            Text("Search")
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
            Text("Settings")
                .tabItem {
                    Image(systemName: "gearshape")
                }
        }
        .onAppear() {
            UITabBar.appearance().backgroundColor = .white
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
