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
                        completion: @escaping (UserProfile) -> Void) {
        
        ApiService.shared.getPlayerSummaries(steamId: steamId) { [weak self] in
            self?.didGetPlayerSummaries(response: $0.response, completion: completion)
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

// MARK: - Private

private extension SteamUserService {
 
    func didGetPlayerSummaries(response: PlayerSummariesResponse,
                               completion: (UserProfile) -> Void) {
        
        guard let player = response.players.first else { return }
        
        let userProfile = UserProfile(userName: player.personaName,
                                      realName: player.realName,
                                      avatarUrl: URL(string: player.avatarFull),
                                      isPrivate: player.communityVisibilityState == .private,
                                      onlineStatus: player.personaState)
        
        completion(userProfile)
    }
    
}
