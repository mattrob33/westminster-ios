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
                    
                    Text("WSC")
                        .font(.custom("EBGaramond-Bold", size: 32))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 72)
                    
                    ForEach(wsc.questions.indices) { i in
                        VStack(alignment: .leading) {
                            let qa = wsc.questions[i]
                            
                            Text("Q\(i + 1). \(qa.question)")
                                .font(.custom("EBGaramond-Bold", size: 20))
                                .foregroundColor(Color(red: 0.83, green: 0.84, blue: 0.85))
                                .lineSpacing(8)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.bottom, 8)
                            
                            Spacer()
                            
                            buildAnswer(qa.answer)
                                .padding(.bottom, 8)
                            
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
        .background(Color(red: 0.16, green: 0.16, blue: 0.17))
        .edgesIgnoringSafeArea(.all)
        .onChange(of: scrollPosition) { target in
            scrollProxy?.scrollTo(target, anchor: .top)
        }
    }
    
    @ViewBuilder
    func buildAnswer(_ answer: String) -> some View {
        
        let parts = answer.split(usingRegex: "\\[[a-z]\\]")
        
        var text = Text("")
        
        for part in parts {
            let isFootnote = part.matches("\\[[a-z]\\]")
            
            text = text + Text(
                isFootnote ?
                part.removeAll("[").removeAll("]")
                    :
                    part
            )
            .font(.custom("EBGaramond-Regular", size: isFootnote ? 16 : 20))
            .baselineOffset(isFootnote ? 6 : 0)
            .foregroundColor(
                isFootnote ?
                    Color(red: 0.67, green: 0.62, blue: 0.44)
                    :
                    Color(red: 0.83, green: 0.84, blue: 0.85)
            )
        }
        
        return text
            .lineSpacing(8)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}
