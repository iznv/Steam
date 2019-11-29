//
//  AuthService.swift
//  Steam
//
//  Created by Ivan Zinovyev on 25/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import Foundation

class AuthService {
    
    // MARK: - Services
    
    private let userDefaults = UserDefaults.standard
    
    // MARK: Properties
    
    var isLoggenIn: Bool {
        return steamId != nil
    }
    
    var steamId: String? {
        return userDefaults.steamId
    }
    
}

// MARK: - Public

extension AuthService {
    
    func login(steamId: String) {
        userDefaults.steamId = steamId
        NotificationCenter.default.post(name: .didChangeAuthState, object: nil)
    }
    
    func logout() {
        userDefaults.steamId = nil
        NotificationCenter.default.post(name: .didChangeAuthState, object: nil)
        CoreDataService.shared.clear()
    }
    
}
