//
//  NumberOfCurrentPlayersResponse.swift
//  Steam
//
//  Created by Ivan Zinovyev on 22/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

public struct NumberOfCurrentPlayersResponse: Codable {
    
    public let playerCount: Int?
    
    public let result: Int

}

private extension NumberOfCurrentPlayersResponse {
    
    enum CodingKeys: String, CodingKey {
        
        case playerCount = "player_count"
        
        case result
        
    }
    
}
