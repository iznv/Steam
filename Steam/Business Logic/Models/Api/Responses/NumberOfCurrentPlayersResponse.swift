//
//  NumberOfCurrentPlayersResponse.swift
//  Steam
//
//  Created by Ivan Zinovyev on 22/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

struct NumberOfCurrentPlayersResponse: Codable {
    
    let playerCount: Int?
    
    let result: Int

}

private extension NumberOfCurrentPlayersResponse {
    
    enum CodingKeys: String, CodingKey {
        
        case playerCount = "player_count"
        
        case result
        
    }
    
}
