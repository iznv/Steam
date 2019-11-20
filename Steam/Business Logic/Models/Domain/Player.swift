//
//  Player.swift
//  Steam
//
//  Created by Ivan Zinovyev on 20/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

struct Player: Codable {
    
    let steamId: String
    
    let communityVisibilityState: Int
    
    let profileState: Int
    
    let personaName: String
    
    let lastLogOff: Int
    
    let profileUrl: String
    
    let avatar: String
    
    let avatarMedium: String
    
    let avatarFull: String
    
    let personaState: Int
    
    let realName: String
    
    let primaryClanId: String
    
    let timeCreated: Int
    
    let personaStateFlags: Int
    
    let locCountryCode: String
    
    let locStateCode: String
    
    let locCityId: Int
    
}

private extension Player {
    
    enum CodingKeys: String, CodingKey {
        
        case steamId = "steamid"
        
        case communityVisibilityState = "communityvisibilitystate"
        
        case profileState = "profilestate"
        
        case personaName = "personaname"
        
        case lastLogOff = "lastlogoff"
        
        case profileUrl = "profileurl"
        
        case avatar
        
        case avatarMedium = "avatarmedium"
        
        case avatarFull = "avatarfull"
        
        case personaState = "personastate"
        
        case realName = "realname"
        
        case primaryClanId = "primaryclanid"
        
        case timeCreated = "timecreated"
        
        case personaStateFlags = "personastateflags"
        
        case locCountryCode = "loccountrycode"
        
        case locStateCode = "locstatecode"
        
        case locCityId = "loccityid"
        
    }
    
}
