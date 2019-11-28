//
//  ThemeManager.swift
//  Steam
//
//  Created by Ivan Zinovyev on 27/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import Foundation

enum ThemeManager {
    
    // MARK: - Properties
    
    private static let defaultTheme: Theme = darkTheme
    
    private static let darkTheme = DarkTheme()
    
    private static let lightTheme = LightTheme()
    
    private static let themes: [Theme] = [
        darkTheme,
        lightTheme
    ]
    
    private static let userDefaults = UserDefaults.standard

}

// MARK: - Computed Properties

extension ThemeManager {
    
    static var theme: Theme {
        get {
            return themes.first { String(describing: $0) == userDefaults.theme } ?? defaultTheme
        }
        set {
            userDefaults.theme = String(describing: newValue)
        }
    }
    
}

// MARK: - Public

extension ThemeManager {
    
    static func apply(theme: Theme) {
        NotificationCenter.default.post(name: .didChangeTheme, object: nil)
    }
    
    static func toggleTheme() {
        switch theme {
        case is LightTheme:
            theme = darkTheme
        case is DarkTheme:
            theme = lightTheme
        default:
            theme = defaultTheme
        }

        apply(theme: theme)
    }

}
