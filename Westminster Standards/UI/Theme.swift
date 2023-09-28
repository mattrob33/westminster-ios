//
//  Theme.swift
//  Westminster Standards
//
//  Created by Matt Robertson on 9/26/23.
//

import SwiftUI

class Theme: ObservableObject {
    var accentColor: Color { Color(red: 180/255, green: 160/255, blue: 115/255) }

    var backgroundColor: Color { Color(red: 1.0, green: 1.0, blue: 1.0) }
    var backgroundAccentColor: Color { Color(red: 0.95, green: 0.95, blue: 0.95) }
    
    var primaryTextColor: Color { Color(red: 0.26, green: 0.27, blue: 0.28) }
    var secondaryTextColor: Color { Color(red: 0.37, green: 0.38, blue: 0.4) }
    
    var subduedIconColor: Color { Color(red: 0.37, green: 0.38, blue: 0.4) }

    let titleFont: Font = .custom("EBGaramond-Medium", size: 24)
    let headingFont: Font = .custom("EBGaramond-Bold", size: 22)
    let bodyFont: Font = .custom("EBGaramond-Regular", size: 24)
    let footnoteFont: Font = .custom("EBGaramond-Regular", size: 18)
}

class LightTheme: Theme {
    override var accentColor: Color { Color(red: 180/255, green: 160/255, blue: 115/255) }
    
    override var backgroundColor: Color { Color(red: 1.0, green: 1.0, blue: 1.0) }
    override var backgroundAccentColor: Color { Color(red: 0.95, green: 0.95, blue: 0.95) }
    
    override var primaryTextColor: Color { Color(red: 0.26, green: 0.27, blue: 0.28) }
    override var secondaryTextColor: Color { Color(red: 0.37, green: 0.38, blue: 0.4) }
    
    override var subduedIconColor: Color { Color(red: 0.37, green: 0.38, blue: 0.4) }
}

class DarkTheme: Theme {
    override var accentColor: Color { Color(red: 0.67, green: 0.62, blue: 0.44) }
    
    override var backgroundColor: Color { Color(red: 0.16, green: 0.16, blue: 0.17) }
    override var backgroundAccentColor: Color { Color(red: 0.13, green: 0.13, blue: 0.13) }
    
    override var primaryTextColor: Color { Color(red: 0.83, green: 0.84, blue: 0.85) }
    override var secondaryTextColor: Color { Color(red: 0.61, green: 0.62, blue: 0.64) }
    
    override var subduedIconColor: Color { Color(red: 0.61, green: 0.62, blue: 0.64) }
}

extension Theme {
    static let light = LightTheme()
    static let dark = DarkTheme()
}
