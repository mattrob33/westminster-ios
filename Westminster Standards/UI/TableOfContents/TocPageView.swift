//
//  TocPageView.swift
//  Westminster Standards
//
//  Created by Matt Robertson on 1/12/22.
//

import SwiftUI

struct TocPageView: View {
    
    @EnvironmentObject var theme: Theme

    var items: [String]
    var onItemSelected: (Int) -> Void
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading) {
                
                Spacer(minLength: 60)

                ForEach(items.indices) { i in
                    Text("Q\(i + 1). \(items[i])")
                        .font(.system(size: 18, design: .default))
                        .foregroundColor(theme.primaryTextColor)
                        .padding(.vertical, 4)
                        .onTapGesture {
                            onItemSelected(i)
                        }
                    
                    Divider()
                }
            }
            .padding(.bottom, 16)
            .padding(.leading)
            .padding(.trailing)
            .background(theme.backgroundColor)
        }
        .background(theme.backgroundColor)
    }
}
