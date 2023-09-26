//
//  Theme.swift
//  Westminster Standards
//
//  Created by Matt Robertson on 9/26/23.
//

import SwiftUI

class Theme: ObservableObject {
    var accentColor: Color { Color(red: 0.58, green: 0.52, blue: 0.34) }

    var backgroundColor: Color { Color(red: 1.0, green: 1.0, blue: 1.0) }
    var backgroundAccentColor: Color { Color(red: 0.95, green: 0.95, blue: 0.95) }
    
    var primaryTextColor: Color { Color(red: 0.26, green: 0.27, blue: 0.28) }
    var secondaryTextColor: Color { Color(red: 0.37, green: 0.38, blue: 0.4) }
    
    var subduedIconColor: Color { Color(red: 0.37, green: 0.38, blue: 0.4) }

    let bodyFont: Font = .custom("EBGaramond-Regular", size: 20)
    let titleFont: Font = .custom("EBGaramond-Medium", size: 24)
}

class LightTheme: Theme {
    override var accentColor: Color { Color(red: 0.58, green: 0.52, blue: 0.34) }
    
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
