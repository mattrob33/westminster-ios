//
//  Westminster_StandardsApp.swift
//  Westminster Standards
//
//  Created by Matt Robertson on 1/7/22.
//

import SwiftUI

@main
struct Westminster_StandardsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(
                contentLocation: ContentLocation(
                    content: Content.wcf,
                    location: 0
                )
            )
        }
    }
    
}
