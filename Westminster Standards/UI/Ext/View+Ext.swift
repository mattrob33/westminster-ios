//
//  View+Ext.swift
//  Westminster Standards
//
//  Created by Matt Robertson on 9/26/23.
//

import SwiftUI

struct AppFont: ViewModifier {
    
    let size: Int
    
    func body(content: Content) -> some View {
        content
            .font(.custom("EBGaramond-Regular", size: CGFloat(size)))
    }
}

extension Text {
    func appFont(size: Int) -> some View {
        modifier(AppFont(size: size))
    }
}
