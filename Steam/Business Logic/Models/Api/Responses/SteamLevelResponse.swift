//
//  SteamLevelResponse.swift
//  Steam
//
//  Created by Ivan Zinovyev on 21/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

struct SteamLevelResponse: Codable {
    
    let playerLevel: Int

}

private extension SteamLevelResponse {
    
    enum CodingKeys: String, CodingKey {
        
        case playerLevel = "player_level"

    }
    
}
