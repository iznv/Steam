//
//  UserDefaults+Keys.swift
//  Steam
//
//  Created by Ivan Zinovyev on 26/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    // MARK: - Keys
    
    enum Keys {
        
        static let steamId = "steamId"
        
        static let theme = "theme"
        
    }

}

// MARK: - Values

extension UserDefaults {

    var steamId: String? {
        get {
            return string(forKey: Keys.steamId)
        }
        set {
            set(newValue, forKey: Keys.steamId)
        }
    }
    
    var theme: String? {
        get {
            return string(forKey: Keys.theme)
        }
        set {
            set(newValue, forKey: Keys.theme)
        }
    }
    
}
