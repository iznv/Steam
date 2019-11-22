//
//  PlayerService.swift
//  Steam
//
//  Created by Ivan Zinovyev on 20/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

class SteamPlayerService {
    
    func getRecentlyPlayedGames(steamId: String,
                                completion: @escaping ([Game]) -> Void) {
        
        ApiService.shared.getRecentlyPlayedGames(steamId: steamId) {
            completion($0.response.games)
        }
    }
    
    func getOwnedGames(steamId: String,
                       completion: @escaping ([OwnedGame]) -> Void) {
        
        ApiService.shared.getOwnedGames(steamId: steamId) {
            completion($0.response.games)
        }
    }
    
    func getSteamLevel(steamId: String,
                       completion: @escaping (Int) -> Void) {
        
        ApiService.shared.getSteamLevel(steamId: steamId) {
            completion($0.response.playerLevel)
        }
    }
    
    func getBadges(steamId: String,
                   completion: @escaping (BadgesResponse) -> Void) {
        
        ApiService.shared.getBadges(steamId: steamId) {
            completion($0.response)
        }
    }
    
    func getCommunityBadgeProgress(steamId: String,
                                   badgeId: Int,
                                   completion: @escaping (CommunityBadgeProgressResponse) -> Void) {
        
        ApiService.shared.getCommunityBadgeProgress(steamId: steamId,
                                                    badgeId: badgeId) {
            completion($0.response)
        }
    }
    
}
