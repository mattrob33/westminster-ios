//
//  ContentView.swift
//  Westminster Standards
//
//  Created by Matt Robertson on 1/7/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        let loadWcfUseCase = LoadWcfUseCase()
        let wcf = loadWcfUseCase.execute()

        if let wcf = wcf {
            Text(wcf.title).padding()
        } else {
            Text("No WCF").padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
