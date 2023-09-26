//
//  TableOfContentsView.swift
//  Westminster Standards
//
//  Created by Matt Robertson on 1/12/22.
//

import SwiftUI

struct TableOfContentsView: View {
    
    @State var content: WestminsterContent
    
    @EnvironmentObject var theme: Theme
    
    var wcf: WCF
    var wlc: WLC
    var wsc: WSC

    var recentWcfChapter: Int
    var recentWlcQuestion: Int
    var recentWscQuestion: Int
    
    var onItemSelected: (WestminsterContent, Int) -> Void
    var onTapDone: () -> Void

    var body: some View {
        
        let wcfView = TocPageView(
            items: wcf.chapters.map { $0.title },
            recentItem: recentWcfChapter,
            onItemSelected: { question in
                onItemSelected(.wcf, question)
            }
        )
        
        let wlcView = TocPageView(
            items: wlc.questions.map { $0.question },
            recentItem: recentWlcQuestion,
            onItemSelected: { question in
                onItemSelected(.wlc, question)
            }
        )
        
        let wscView = TocPageView(
            items: wsc.questions.map { $0.question },
            recentItem: recentWscQuestion,
            onItemSelected: { question in
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
                    .foregroundColor(theme.accentColor)
                    .onTapGesture {
                        onTapDone()
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.top).padding(.trailing)
            }
            
            Divider()
            
            Picker("Content", selection: $content) {
                Text("Confession").tag(WestminsterContent.wcf)
                Text("Larger").tag(WestminsterContent.wlc)
                Text("Shorter").tag(WestminsterContent.wsc)
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
        .background(theme.backgroundColor)
    }
}
