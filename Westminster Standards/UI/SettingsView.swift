//
//  SettingsView.swift
//  Westminster Standards
//
//  Created by Matt Robertson on 1/15/22.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var settings: Settings
    
    @State var fontSize: Int

    var body: some View {
        VStack {
            Text("Settings")
                .frame(maxWidth: .infinity, alignment: .center)
                .font(.system(size: 24))
                .padding()

            HStack {
                Text("Font size")

                Picker("Font size", selection: $fontSize) {
                    Text("Huge").tag(36)
                    Text("Extra Large").tag(28)
                    Text("Large").tag(24)
                    Text("Medium").tag(22)
                    Text("Small").tag(18)
                    Text("Extra Small").tag(16)
                }
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .onChange(of: fontSize) { fontSize in
            settings.fontSize = fontSize
        }
    }
}
