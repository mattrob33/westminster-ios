//
//  SettingsView.swift
//  Westminster Standards
//
//  Created by Matt Robertson on 1/15/22.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var settings: Settings

    var body: some View {
        VStack {
            Picker("Font size", selection: $settings.fontSize) {
                Text("Extra Small").tag(16)
                Text("Small").tag(18)
                Text("Medium").tag(22)
                Text("Large").tag(24)
                Text("Extra Large").tag(28)
                Text("Huge").tag(36)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
    
}
