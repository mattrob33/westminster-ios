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
    var recentItem: Int
    var onItemSelected: (Int) -> Void
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading) {
                
                Spacer(minLength: 60)
                
                ZStack {
                    Text("\(recentItem + 1). \(items[recentItem])")
                        .font(.system(size: 18, design: .default))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.trailing, 32)
                        .foregroundColor(theme.accentColor)
                    
                    Text("❯")
                        .font(.system(size: 20, design: .default))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .foregroundColor(theme.accentColor)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .fill(theme.backgroundAccentColor)
                )
                .onTapGesture {
                    onItemSelected(recentItem)
                }
                
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
