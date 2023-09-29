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

    @State var catechism: any Catechism

    @Binding var scrollPosition: Int
    @State private var scrollProxy: ScrollViewProxy? = nil
    
    @EnvironmentObject var theme: Theme

    var body: some View {
        ZStack {
            ScrollView {
                ScrollViewReader { proxy in
                    
                    LazyVStack(alignment: .leading) {
                        
                        Spacer(minLength: 70)
                            .id(0)
                        
                        ForEachWithIndex(catechism.questions) { i, qa in
                            VStack(alignment: .leading) {
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
            .statusBarHidden(showBottomBar ? false : true)
            
            if showPicker {
                TocPageView(
                    items: catechism.questions.map { $0.question },
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
