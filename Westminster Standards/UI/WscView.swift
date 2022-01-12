//
//  ContentView.swift
//  Westminster Standards
//
//  Created by Matt Robertson on 1/7/22.
//

import SwiftUI

struct WscView: View {

    @State private var recentQuestion = 0

    @State var wsc: WSC

    @Binding var scrollPosition: Int
    @State private var scrollProxy: ScrollViewProxy? = nil

    var body: some View {
        ScrollView {
            ScrollViewReader { proxy in
                
                VStack(alignment: .leading) {
                    ForEach(wsc.questions.indices) { i in
                        VStack(alignment: .leading) {
                            let qa = wsc.questions[i]
                            
                            Text("Q\(i + 1). \(qa.question)")
                                .font(.system(size: 20, weight: .bold, design: .serif))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Spacer()
                            
                            Text(qa.answer)
                                .font(.system(size: 20, design: .serif))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Spacer()
                            
                            let proofs = qa.proofs.components(separatedBy: "\n")
                            
                            ForEach(proofs.indices) { j in
                                Text(proofs[j])
                                    .font(.system(size: 20, design: .serif))
                                    .italic()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .padding(.bottom, 20)
                        .id(i)
                    }
                }
                .onAppear {
                    scrollProxy = proxy
                }
            }
        }
        .padding(.leading)
        .padding(.trailing)
        .onChange(of: scrollPosition) { target in
            scrollProxy?.scrollTo(target, anchor: .top)
        }
    }
}
