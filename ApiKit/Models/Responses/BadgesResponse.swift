//
//  BadgesResponse.swift
//  Steam
//
//  Created by Ivan Zinovyev on 21/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

public struct BadgesResponse: Codable {
    
    public let badges: [Badge]?
    
    public let playerXP: Int?
    
    public let playerLevel: Int?
    
    public let playerXPNeededToLevelUp: Int?
    
    public let playerXPNeededCurrentLevel: Int?
    
}

private extension BadgesResponse {
    
    enum CodingKeys: String, CodingKey {
        
        case badges
        
        case playerXP = "player_xp"
        
        case playerLevel = "player_level"
        
        case playerXPNeededToLevelUp = "player_xp_needed_to_level_up"
        
        case playerXPNeededCurrentLevel = "player_xp_needed_current_level"
    
    }
    
}
