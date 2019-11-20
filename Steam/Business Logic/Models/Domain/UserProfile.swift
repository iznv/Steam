//
//  UserProfile.swift
//  Steam
//
//  Created by Ivan Zinovyev on 20/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import Foundation

struct UserProfile {
    
    let userName: String
    
    let realName: String
    
    let avatarUrl: URL?
    
    let isPrivate: Bool
    
    let onlineStatus: PersonaState

}
