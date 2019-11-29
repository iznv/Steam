//
//  RecentlyPlayedGamesResponse.swift
//  Steam
//
//  Created by Ivan Zinovyev on 20/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

public struct RecentlyPlayedGamesResponse: Codable {
    
    public let totalCount: Int?
    
    public let games: [Game]?
    
}

private extension RecentlyPlayedGamesResponse {
    
    enum CodingKeys: String, CodingKey {
        
        case totalCount = "total_count"
        
        case games
        
    }
    
}
