//
//  OwnedGamesResponse.swift
//  Steam
//
//  Created by Ivan Zinovyev on 20/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

public struct OwnedGamesResponse: Codable {
    
    public let games: [Game]?
    
}

private extension OwnedGamesResponse {
    
    enum CodingKeys: String, CodingKey {
        
        case games
    
    }
    
}
