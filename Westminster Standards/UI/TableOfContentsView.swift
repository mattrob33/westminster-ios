//
//  TableOfContentsView.swift
//  Westminster Standards
//
//  Created by Matt Robertson on 1/12/22.
//

import SwiftUI

struct TableOfContentsView: View {
    
    @Binding var content: Content
    
    var wcf: WCF
    var wlc: WLC
    var wsc: WSC

    var recentWcfChapter: Int
    var recentWlcQuestion: Int
    var recentWscQuestion: Int
    
    var onWcfChapterSelected: (Int) -> Void
    var onWlcQuestionSelected: (Int) -> Void
    var onWscQuestionSelected: (Int) -> Void

    var body: some View {
        
        Picker("Content", selection: $content) {
            Text("Confession").tag(Content.wcf)
            Text("Larger").tag(Content.wlc)
            Text("Shorter").tag(Content.wsc)
        }
        .pickerStyle(SegmentedPickerStyle())
        
        switch (content) {
        case .wcf:
            WcfTableOfContentsView(
                wcf: wcf,
                recentWcfChapter: recentWcfChapter,
                onWcfChapterSelected: onWcfChapterSelected
            )
        case .wlc:
            WlcTableOfContentsView(
                wlc: wlc,
                recentWlcQuestion: recentWlcQuestion,
                onWlcQuestionSelected: onWlcQuestionSelected
            )
        case .wsc:
            WscTableOfContentsView(
                wsc: wsc,
                recentWscQuestion: recentWscQuestion,
                onWscQuestionSelected: onWscQuestionSelected
            )
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
        .background(Color.white)
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
        .background(Color.white)
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
        .background(Color.white)
    }
}
