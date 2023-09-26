//
//  TableOfContentsView.swift
//  Westminster Standards
//
//  Created by Matt Robertson on 1/12/22.
//

import SwiftUI

struct TableOfContentsView: View {
    
    @State var content: Content
    
    var wcf: WCF
    var wlc: WLC
    var wsc: WSC

    var recentWcfChapter: Int
    var recentWlcQuestion: Int
    var recentWscQuestion: Int
    
    var onItemSelected: (Content, Int) -> Void
    var onTapDone: () -> Void

    var body: some View {
        
        let wcfView = WcfTableOfContentsView(
            wcf: wcf,
            recentWcfChapter: recentWcfChapter,
            onWcfChapterSelected: { chapter in
                onItemSelected(.wcf, chapter)
            }
        )
        
        let wlcView = CatechismTableOfContentsView(
            catechism: wlc,
            recentQuestion: recentWlcQuestion,
            onQuestionSelected: { question in
                onItemSelected(.wlc, question)
            }
        )
        
        let wscView = CatechismTableOfContentsView(
            catechism: wsc,
            recentQuestion: recentWscQuestion,
            onQuestionSelected: { question in
                onItemSelected(.wsc, question)
            }
        )

        VStack {
            
            ZStack {
                Text("Contents")
                    .font(.system(size: 20, design: .default))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top).padding(.trailing)
                
                Text("Done")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.gold)
                    .onTapGesture {
                        onTapDone()
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.top).padding(.trailing)
            }
            
            Divider()
            
            Picker("Content", selection: $content) {
                Text("Confession").tag(Content.wcf)
                Text("Larger").tag(Content.wlc)
                Text("Shorter").tag(Content.wsc)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            .padding(.vertical, 4)
            
            switch (content) {
            case .wcf:
                wcfView
            case .wlc:
                wlcView
            case .wsc:
                wscView
            }
        }
        .background(Color.themedBackground)
    }
}


struct WcfTableOfContentsView: View {

    var wcf: WCF
    var recentWcfChapter: Int
    var onWcfChapterSelected: (Int) -> Void
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading) {
                
                HStack {
                    Text("\(recentWcfChapter + 1). \(wcf.chapters[recentWcfChapter].title)")
                        .font(.system(size: 20, design: .default))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.gold)
                    
                    Spacer()
                    
                    Text("❯")
                        .font(.system(size: 20, design: .default))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .foregroundColor(.gold)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color(red: 202/255, green: 236/255, blue: 252/255, opacity: 0.3))
                )
                .onTapGesture {
                    onWcfChapterSelected(recentWcfChapter)
                }
                
                ForEach(wcf.chapters.indices) { i in
                    Text("\(i + 1). \(wcf.chapters[i].title)")
                        .font(.system(size: 20, design: .default))
                        .padding(.top, 1)
                        .onTapGesture {
                            onWcfChapterSelected(i)
                        }
                }
            }
            .padding(.leading)
            .padding(.trailing)
        }
        .background(.background)
    }
}

struct CatechismTableOfContentsView: View {
    
    var catechism: Catechism
    var recentQuestion: Int
    var onQuestionSelected: (Int) -> Void
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading) {
                
                HStack {
                    Text("\(recentQuestion + 1). \(catechism.questions[recentQuestion].question)")
                        .font(.system(size: 20, design: .default))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.gold)
                    
                    Spacer()
                    
                    Text("❯")
                        .font(.system(size: 20, design: .default))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .foregroundColor(.gold)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.backgroundDarker)
                )
                .onTapGesture {
                    onQuestionSelected(recentQuestion)
                }
                
                ForEach(catechism.questions.indices) { i in
                    Text("Q\(i + 1). \(catechism.questions[i].question)")
                        .font(.system(size: 20, design: .default))
                        .foregroundColor(.text)
                        .padding(.top, 1)
                        .onTapGesture {
                            onQuestionSelected(i)
                        }
                    
                    Divider()
                }
            }
            .padding(.leading)
            .padding(.trailing)
            .background(Color.themedBackground)
        }
        .background(Color.themedBackground)
    }
}
