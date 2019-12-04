//
//  ThemeManager.swift
//  Steam
//
//  Created by Ivan Zinovyev on 27/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import UIKit

enum ThemeManager {
    
    // MARK: - Properties
    
    private static var defaultTheme: Theme {
        if #available(iOS 13.0, *),
            let traitCollection = UIApplication.shared.delegate?.window??.traitCollection {
            switch traitCollection.userInterfaceStyle {
            case .dark:
                return darkTheme
            case .light:
                return lightTheme
            default:
                return darkTheme
            }
        } else {
            return darkTheme
        }
    }
    
    private static let darkTheme = DarkTheme()
    
    private static let lightTheme = LightTheme()
    
    private static let xmasTheme = XmasTheme()
    
    private static let themes: [Theme] = [
        darkTheme,
        lightTheme,
        xmasTheme
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
    
    static func applyDark() {
        theme = darkTheme
        apply(theme: theme)
    }
    
    static func applyLight() {
        theme = lightTheme
        apply(theme: theme)
    }
    
    static func toggleTheme() {
        switch theme {
        case is LightTheme:
            theme = darkTheme
        case is DarkTheme:
            theme = xmasTheme
        case is XmasTheme:
            theme = lightTheme
        default:
            theme = defaultTheme
        }

        apply(theme: theme)
    }

}
