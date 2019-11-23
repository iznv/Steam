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
    
    func getBadges(steamId: String,
                   completion: @escaping (BadgesResponse) -> Void) {
        
        ApiService.shared.getBadges(steamId: steamId) {
            completion($0.response)
        }
    }
    
}
