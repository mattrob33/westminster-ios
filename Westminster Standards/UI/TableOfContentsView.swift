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
        
        let wlcView = WlcTableOfContentsView(
            wlc: wlc,
            recentWlcQuestion: recentWlcQuestion,
            onWlcQuestionSelected: { question in
                onItemSelected(.wlc, question)
            }
        )
        
        let wscView = WscTableOfContentsView(
            wsc: wsc,
            recentWscQuestion: recentWscQuestion,
            onWscQuestionSelected: { question in
                onItemSelected(.wsc, question)
            }
        )

        VStack {
            
            ZStack {
                Text("Contents")
                    .font(.system(size: 20, design: .serif))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top).padding(.trailing)
                
                Text("Done")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(Color.accentColor)
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
            
            switch (content) {
            case .wcf:
                wcfView
            case .wlc:
                wlcView
            case .wsc:
                wscView
            }
        }
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
                        .font(.system(size: 20, design: .serif))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(Color.accentColor)
                    
                    Spacer()
                    
                    Text("❯")
                        .font(.system(size: 20, design: .serif))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .foregroundColor(Color.accentColor)
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
                        .font(.system(size: 20, design: .serif))
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

struct WlcTableOfContentsView: View {

    var wlc: WLC
    var recentWlcQuestion: Int
    var onWlcQuestionSelected: (Int) -> Void

    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading) {
                
                HStack {
                    Text("\(recentWlcQuestion + 1). \(wlc.questions[recentWlcQuestion].question)")
                        .font(.system(size: 20, design: .serif))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(Color.accentColor)
                    
                    Spacer()
                    
                    Text("❯")
                        .font(.system(size: 20, design: .serif))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .foregroundColor(Color.accentColor)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color(red: 202/255, green: 236/255, blue: 252/255, opacity: 0.3))
                )
                .onTapGesture {
                    onWlcQuestionSelected(recentWlcQuestion)
                }
                
                ForEach(wlc.questions.indices) { i in
                    Text("Q\(i + 1). \(wlc.questions[i].question)")
                        .font(.system(size: 20, design: .serif))
                        .padding(.top, 1)
                        .onTapGesture {
                            onWlcQuestionSelected(i)
                        }
                }
            }
            .padding(.leading)
            .padding(.trailing)
        }
        .background(.background)
    }
}


struct WscTableOfContentsView: View {
    
    var wsc: WSC
    var recentWscQuestion: Int
    var onWscQuestionSelected: (Int) -> Void
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading) {
                
                HStack {
                    Text("\(recentWscQuestion + 1). \(wsc.questions[recentWscQuestion].question)")
                        .font(.system(size: 20, design: .serif))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(Color.accentColor)
                    
                    Spacer()
                    
                    Text("❯")
                        .font(.system(size: 20, design: .serif))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .foregroundColor(Color.accentColor)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color(red: 202/255, green: 236/255, blue: 252/255, opacity: 0.3))
                )
                .onTapGesture {
                    onWscQuestionSelected(recentWscQuestion)
                }
                
                ForEach(wsc.questions.indices) { i in
                    Text("Q\(i + 1). \(wsc.questions[i].question)")
                        .font(.system(size: 20, design: .serif))
                        .padding(.top, 1)
                        .onTapGesture {
                            onWscQuestionSelected(i)
                        }
                }
            }
            .padding(.leading)
            .padding(.trailing)
        }
        .background(.background)
    }
}
