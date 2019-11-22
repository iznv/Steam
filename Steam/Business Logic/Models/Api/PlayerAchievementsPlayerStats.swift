//
//  PlayerAchievementsPlayerStats.swift
//  Steam
//
//  Created by Ivan Zinovyev on 22/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

struct PlayerAchievementsPlayerStats: Codable {
    
    let achievements: [PlayerAchievement]?
    
    let error: String?
    
    let success: Bool

}
