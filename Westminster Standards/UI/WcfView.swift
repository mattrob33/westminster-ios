//
//  ContentView.swift
//  Westminster Standards
//
//  Created by Matt Robertson on 1/7/22.
//

import SwiftUI

struct WcfView: View {
    var body: some View {
        let loadWcfUseCase = LoadWcfUseCase()
        let wcf = loadWcfUseCase.execute()
        
        NavigationView {
            if let wcf = wcf {
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(wcf.chapters.indices) { i in
                            VStack(alignment: .leading) {
                                let chapter = wcf.chapters[i]
                                
                                Text("Chapter \(i + 1)")
                                    .font(.system(size: 24, weight: .bold, design: .serif))
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .padding(.top)
                                
                                Text(chapter.title)
                                    .font(.system(size: 22, weight: .bold, design: .serif))
                                    .frame(maxWidth: .infinity, alignment: .center)
                                
                                ForEach(chapter.sections.indices) { j in
                                    let section = chapter.sections[j]

                                    Text("\(j + 1). \(section.text)")
                                        .font(.system(size: 18, design: .serif))
                                        .lineSpacing(9)
                                        .padding(.top)
                                }
                            }
                            .padding(.bottom, 100)
                        }
                    }
                    .padding(.leading)
                    .padding(.trailing)
                    .navigationBarTitle(wcf.abbrv)
                    .navigationBarTitleDisplayMode(.inline)
                }
            } else {
                Text("Unable to load WCF").padding()
            }
        }
    }
}
