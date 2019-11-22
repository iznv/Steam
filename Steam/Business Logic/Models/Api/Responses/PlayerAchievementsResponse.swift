//
//  PlayerAchievementsResponse.swift
//  Steam
//
//  Created by Ivan Zinovyev on 22/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

struct PlayerAchievementsResponse: Codable {
    
    let playerStats: PlayerAchievementsPlayerStats
    
}

private extension PlayerAchievementsResponse {
    
    enum CodingKeys: String, CodingKey {
        
        case playerStats = "playerstats"

    }
    
}
