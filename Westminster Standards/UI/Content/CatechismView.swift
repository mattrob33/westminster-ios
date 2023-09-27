//
//  CatechismView.swift
//  Westminster Standards
//
//  Created by Matt Robertson on 9/26/23.
//

import SwiftUI

struct CatechismView: View {

    @State private var showTopBar = true
    @State private var showBottomBar = true

    @State private var showPicker = false
    
    @State private var recentQuestion = 0

    @State var catechism: Catechism

    @Binding var scrollPosition: Int
    @State private var scrollProxy: ScrollViewProxy? = nil
    
    @EnvironmentObject var theme: Theme

    var body: some View {
        ZStack {
            ScrollView {
                ScrollViewReader { proxy in
                    
                    VStack(alignment: .leading) {
                        
                        Spacer(minLength: 70)
                            .id(0)
                        
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
                            .id(i + 1)
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
            .onTapGesture {
                withAnimation {
                    showTopBar.toggle()
                    showBottomBar.toggle()
                }
            }
            .toolbar(showBottomBar ? .visible : .hidden, for: .tabBar)
            
            if showPicker {
                TocPageView(
                    items: catechism.questions.map { $0.question },
                    recentItem: recentQuestion,
                    onItemSelected: { num in
                        scrollPosition = num + 1
                        showPicker = false
                        withAnimation {
                            showTopBar = false
                            showBottomBar = false
                        }
                    }
                )
                .padding(.top, 50)
            }
            
        }
        .background(theme.backgroundColor)
        .edgesIgnoringSafeArea(.all)
        .onChange(of: scrollPosition) { target in
            scrollProxy?.scrollTo(target, anchor: .top)
        }
        .overlay(alignment: .top) {
            if showTopBar {
                TopBar(
                    title: catechism.title,
                    isExpanded: showPicker,
                    onTap: {
                        showPicker.toggle()
                        showBottomBar = !showPicker
                    }
                )
            }
        }
        
    }
}
