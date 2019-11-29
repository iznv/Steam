//
//  Player.swift
//  Steam
//
//  Created by Ivan Zinovyev on 20/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import Foundation

public struct Player: Codable {
    
    public let steamId: String
    
    public let communityVisibilityState: CommunityVisibilityState
    
    public let profileState: Int?
    
    public let personaName: String
    
    public let lastLogOff: Int?
    
    public let profileUrl: String
    
    public let avatar: String
    
    public let avatarMedium: String
    
    public let avatarFull: String
    
    public let personaState: PersonaState
    
    public let realName: String?
    
    public let primaryClanId: String?
    
    public let timeCreated: Date?
    
    public let personaStateFlags: Int?
    
    public let locCountryCode: String?
    
    public let locStateCode: String?
    
    public let locCityId: Int?
    
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
