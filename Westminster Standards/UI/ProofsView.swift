//
//  ProofsView.swift
//  Westminster Standards
//
//  Created by Matt Robertson on 9/26/23.
//

import SwiftUI

struct ProofsView: View {

    let proofs: [Proofs]
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(proofs.indices) { k in
                buildProofsText(proofs[k])
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    private func buildProofsText(_ proofs: Proofs) -> Text {
        let text = proofs.refs.joined(separator: "; ")
        Text("\(proofs.number). \(text)")
            .font(.custom("EBGaramond-Regular", size: 18))
            .foregroundColor(.gold)
    }

}
