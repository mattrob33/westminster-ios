//
//  Westminster_StandardsApp.swift
//  Westminster Standards WatchKit Extension
//
//  Created by Matt Robertson on 1/7/22.
//

import SwiftUI

struct Westminster_StandardsApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
