//
//  SteamUserService.swift
//  Steam
//
//  Created by Ivan Zinovyev on 20/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import Foundation

class SteamUserService {
    
    func getUserProfile(completion: @escaping (UserProfile) -> Void) {
        ApiService.shared.getPlayerSummaries { [weak self] response in
            self?.didGetPlayerSummaries(response: response, completion: completion)
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
