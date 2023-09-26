//
//  Westminster_StandardsApp.swift
//  Westminster Standards
//
//  Created by Matt Robertson on 1/7/22.
//

import SwiftUI

@main
struct Westminster_StandardsApp: App {
    
    @StateObject var settings = Settings()

    var theme: Theme { .dark }
    
    var body: some Scene {
        WindowGroup {
            ContentView(
                contentLocation: ContentLocation(
                    content: .wcf,
                    location: 0
                )
            )
            .environmentObject(settings)
            .environmentObject(theme)
        }
    }
    
}
