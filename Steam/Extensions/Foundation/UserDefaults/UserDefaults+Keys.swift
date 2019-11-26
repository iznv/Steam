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
    
}
