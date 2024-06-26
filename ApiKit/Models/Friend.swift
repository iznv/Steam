//
//  Friend.swift
//  Steam
//
//  Created by Ivan Zinovyev on 22/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

public struct Friend: Codable {
    
    public let steamId: String
    
    public let relationship: String
    
    public let friendSince: Int

}

private extension Friend {

    enum CodingKeys: String, CodingKey {
        
        case steamId = "steamid"
        
        case relationship
        
        case friendSince = "friend_since"
        
    }
    
}
