//
//  GetOwnedGamesResponse.swift
//  Steam
//
//  Created by Ivan Zinovyev on 20/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

struct GetOwnedGamesResponse: Codable {
    
    let gameCount: Int
    
    let games: [OwnedGame]
    
}

private extension GetOwnedGamesResponse {
    
    enum CodingKeys: String, CodingKey {
    
        case gameCount = "game_count"
        
        case games
    
    }
    
}
