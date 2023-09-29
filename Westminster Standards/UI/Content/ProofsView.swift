//
//  ProofsView.swift
//  Westminster Standards
//
//  Created by Matt Robertson on 9/26/23.
//

import SwiftUI

struct ProofsView: View {

    let proofs: [Proofs]
    
    @EnvironmentObject var theme: Theme

    var body: some View {
        LazyVStack(alignment: .leading) {
            ForEach(proofs) { proofs in
                buildProofsText(proofs)
                    .padding(.bottom, 1)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    private func buildProofsText(_ proofs: Proofs) -> some View {
        let text = proofs.refs.joined(separator: "; ")
        Text("\(proofs.number). \(text)")
            .font(theme.footnoteFont)
            .foregroundColor(theme.accentColor)
            .onTapGesture {
                if
                    let url = URL(string: "https://www.esv.org/verses/\(text)"),
                    UIApplication.shared.canOpenURL(url)
                {
                    UIApplication.shared.open(url)
                }
            }
    }

}
