//
//  ThemeManager.swift
//  Westminster Standards
//
//  Created by Matt Robertson on 9/26/23.
//

import Foundation
import SwiftUI

class ThemeManager: ObservableObject {

    @Published var currentTheme: Theme

    init(theme: Theme) {
        self.currentTheme = theme
        observeSystemColorScheme()
    }

    func setTheme(_ theme: Theme) {
        self.currentTheme = theme
    }

    private func observeSystemColorScheme() {
        NotificationCenter.default.addObserver(self, selector: #selector(colorSchemeDidChange), name: .colorSchemeDidChange, object: nil)
    }

    @objc private func colorSchemeDidChange() {
        switch UIApplication.shared.windows.first?.traitCollection.userInterfaceStyle {
        case .dark:
            setTheme(.dark)
        case .light, .unspecified:
            setTheme(.light)
        default:
            break
        }
    }
}

extension Notification.Name {
    static let colorSchemeDidChange = Notification.Name("colorSchemeDidChange")
}
