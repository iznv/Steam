//
//  UserStatsForGameResponse.swift
//  Steam
//
//  Created by Ivan Zinovyev on 22/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

struct UserStatsForGameResponse: Codable {
    
    let playerStats: UserStatsForGamePlayerStats?
    
}

private extension UserStatsForGameResponse {
    
    enum CodingKeys: String, CodingKey {
        
        case playerStats = "playerstats"

    }
    
}
