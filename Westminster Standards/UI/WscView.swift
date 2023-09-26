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
                    
                    Title("WSC")
                    
                    ForEach(wsc.questions.indices) { i in
                        VStack(alignment: .leading) {
                            let qa = wsc.questions[i]
                            
                            Question(num: i + 1, question: qa.question)
                            
                            Spacer()

                            Answer(qa.answer)
                            
                            Spacer()
                            
                            ForEach(qa.proofs.indices) { k in
                                let proofs = qa.proofs[k]
                                buildProofsText(proofs)
                            }
                            
                            Spacer()
                        }
                        .padding(.top, 24)
                        .id(i)
                    }
                }
                .onAppear {
                    scrollProxy = proxy
                    proxy.scrollTo(scrollPosition, anchor: .top)
                }
            }
        }
        .padding(.top, 20)
        .padding(.leading)
        .padding(.trailing)
        .background(Color.themedBackground)
        .edgesIgnoringSafeArea(.all)
        .onChange(of: scrollPosition) { target in
            scrollProxy?.scrollTo(target, anchor: .top)
        }
    }
}
