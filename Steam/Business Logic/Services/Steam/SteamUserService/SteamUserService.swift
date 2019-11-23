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
                        completion: @escaping (Result<[Player], ApiService.Error>) -> Void) {
        
        ApiService.shared.getPlayerSummaries(steamId: steamId) {
            completion($0.map { $0.response.players })
        }
    }
    
    func getFriendList(steamId: String,
                       completion: @escaping (Result<[Friend], ApiService.Error>) -> Void) {
        
        ApiService.shared.getFriendList(steamId: steamId) {
            completion($0.map { $0.friendsList.friends })
        }
    }
    
    func getUserGroupList(steamId: String,
                          completion: @escaping (Result<[Group], ApiService.Error>) -> Void) {
        
        ApiService.shared.getUserGroupList(steamId: steamId) {
            if case let .success(data) = $0 {
                if data.response.success {
                    completion($0.map { $0.response.groups })
                } else {
                    completion($0.map { _ in [] })
                }
            } else {
                completion($0.map { _ in [] })
            }
        }
    }
    
}
