//
//  Friend.swift
//  Steam
//
//  Created by Ivan Zinovyev on 22/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

struct Friend: Codable {
    
    let steamid: String
    
    let relationship: String
    
    let friendSince: Int

}

private extension Friend {

    enum CodingKeys: String, CodingKey {
        
        case steamid
        
        case relationship
        
        case friendSince = "friend_since"
        
    }
    
}
