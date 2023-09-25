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
                                .font(.custom("EBGaramond-Bold", size: 20))
                                .foregroundColor(Color(red: 0.83, green: 0.84, blue: 0.85))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Spacer()
                            
                            Text(qa.answer)
                                .font(.custom("EBGaramond-Regular", size: 20))
                                .foregroundColor(Color(red: 0.83, green: 0.84, blue: 0.85))
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
        .padding(.top, 20)
        .padding(.leading)
        .padding(.trailing)
        .background(Color(red: 0.16, green: 0.16, blue: 0.17))
        .onChange(of: scrollPosition) { target in
            scrollProxy?.scrollTo(target, anchor: .top)
        }
    }
}
