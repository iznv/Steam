//
//  AvailableGameStats.swift
//  Steam
//
//  Created by Ivan Zinovyev on 22/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

struct AvailableGameStats: Codable {
    
    let stats: [SchemaStat]?
    
    let achievements: [SchemaAchievement]?
    
}

extension AvailableGameStats {
    
    var isEmpty: Bool {
        let noAchievements = achievements == nil ? true : achievements?.isEmpty == true
        let noStats = stats == nil ? true : stats?.isEmpty == true
        
        return noAchievements && noStats
    }
    
}
