//
//  PlayerAchievement.swift
//  Steam
//
//  Created by Ivan Zinovyev on 22/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

struct PlayerAchievement: Codable {
    
    let apiName: String
    
    let achieved: Int
    
    let unlockTime: Int
    
}

private extension PlayerAchievement {
    
    enum CodingKeys: String, CodingKey {
        
        case apiName = "apiname"
        
        case achieved
        
        case unlockTime = "unlocktime"

    }
    
}
