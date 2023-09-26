//
//  TocPageView.swift
//  Westminster Standards
//
//  Created by Matt Robertson on 1/12/22.
//

import SwiftUI

struct TocPageView: View {

    var items: [String]
    var recentItem: Int
    var onItemSelected: (Int) -> Void
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading) {
                
                HStack {
                    Text("\(recentItem + 1). \(items[recentItem])")
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
                    onItemSelected(recentItem)
                }
                
                ForEach(items.indices) { i in
                    Text("Q\(i + 1). \(items[i])")
                        .font(.system(size: 20, design: .default))
                        .foregroundColor(.text)
                        .padding(.top, 1)
                        .onTapGesture {
                            onItemSelected(i)
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
