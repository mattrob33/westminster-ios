//
//  ContentView.swift
//  Westminster Standards
//
//  Created by Matt Robertson on 1/7/22.
//

import SwiftUI

struct WlcView: View {

    @State private var recentQuestion = 0

    @State var wlc: WLC

    @Binding var scrollPosition: Int
    @State private var scrollProxy: ScrollViewProxy? = nil

    var body: some View {
        ScrollView {
            ScrollViewReader { proxy in
                
                VStack(alignment: .leading) {
                    ForEach(wlc.questions.indices) { i in
                        VStack(alignment: .leading) {
                            let qa = wlc.questions[i]
                            
                            Text("Q\(i + 1). \(qa.question)")
                                .font(.system(size: 20, weight: .bold, design: .serif))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Spacer()
                            
                            Text(qa.answer)
                                .font(.system(size: 20, design: .serif))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Spacer()
                            
                            ForEach(qa.proofs.indices) { k in
                                let proofs = qa.proofs[k]
                                buildProofsText(proofs)
                            }
                            
                            Spacer()
                        }
                        .padding(.bottom, 20)
                        .id(i)
                    }
                }
                .onAppear {
                    scrollProxy = proxy
                    proxy.scrollTo(scrollPosition, anchor: .top)
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
