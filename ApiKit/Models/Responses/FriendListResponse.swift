//
//  FriendListResponse.swift
//  Steam
//
//  Created by Ivan Zinovyev on 22/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

public struct FriendListResponse: Codable {
    
    public let friendsList: FriendsList?

}

private extension FriendListResponse {
    
    enum CodingKeys: String, CodingKey {
        
        case friendsList = "friendslist"
    
    }

}
