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
            ScrollView {
                VStack(alignment: .leading) {
                    Text(wcf.title)
                        .font(.system(size: 20))
                        .padding(.top)
                    
                    ForEach(wcf.chapters, id: \.self) { chapter in
                        Text(chapter.title)
                            .font(.system(size: 18))
                            .padding(.top)
                        
                        ForEach(chapter.sections, id: \.self) { section in
                            Text(section.text).padding(.top)
                        }
                    }
                }.padding()
            }
        } else {
            Text("Unable to load WCF").padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
