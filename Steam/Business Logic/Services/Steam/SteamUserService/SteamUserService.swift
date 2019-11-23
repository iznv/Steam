//
//  SteamUserService.swift
//  Steam
//
//  Created by Ivan Zinovyev on 20/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import Foundation

class SteamUserService {
    
    func getUserProfile(steamId: String,
                        completion: @escaping ([Player]) -> Void) {
        
        ApiService.shared.getPlayerSummaries(steamId: steamId) {
            completion($0.response.players)
        }
    }
    
    func getFriendList(steamId: String,
                       completion: @escaping ([Friend]) -> Void) {
        
        ApiService.shared.getFriendList(steamId: steamId) {
            completion($0.friendsList.friends)
        }
    }
    
    func getUserGroupList(steamId: String,
                          completion: @escaping ([Group]) -> Void) {
        
        ApiService.shared.getUserGroupList(steamId: steamId) {
            if $0.response.success {
                completion($0.response.groups)
            } else {
                completion([])
            }
        }
    }
    
}
