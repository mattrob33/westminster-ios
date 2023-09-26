//
//  CatechismView.swift
//  Westminster Standards
//
//  Created by Matt Robertson on 9/26/23.
//

import SwiftUI

struct CatechismView: View {

    @State private var recentQuestion = 0

    @State var catechism: Catechism

    @Binding var scrollPosition: Int
    @State private var scrollProxy: ScrollViewProxy? = nil

    var body: some View {
        ScrollView {
            ScrollViewReader { proxy in
                
                VStack(alignment: .leading) {
                    
                    Title(catechism.abbrv)
                    
                    ForEach(catechism.questions.indices) { i in
                        VStack(alignment: .leading) {
                            let qa = catechism.questions[i]
                            
                            Question(num: i + 1, question: qa.question)
                            Spacer()
                            Answer(qa.answer)
                            Spacer()
                            ProofsView(proofs: qa.proofs)
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
