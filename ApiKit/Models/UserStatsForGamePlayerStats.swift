//
//  UserStatsForGamePlayerStats.swift
//  Steam
//
//  Created by Ivan Zinovyev on 22/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

public struct UserStatsForGamePlayerStats: Codable {
    
    public let stats: [Stat]?
    
    public let achievements: [Achievement]?
    
}
