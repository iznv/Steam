//
//  PlayerService.swift
//  Steam
//
//  Created by Ivan Zinovyev on 20/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import Foundation

class PlayerService {
    
    func getRecentlyPlayedGames(steamId: String,
                                completion: @escaping ([Game]) -> Void) {
        
        ApiService.shared.getRecentlyPlayedGames(steamId: steamId) { [weak self] response in
            self?.didGetRecentlyPlayedGames(response: response, completion: completion)
        }
    }
    
    func getOwnedGames(steamId: String,
                       completion: @escaping ([OwnedGame]) -> Void) {
        
        ApiService.shared.getOwnedGames(steamId: steamId) { [weak self] response in
            self?.didGetOwnedGames(response: response, completion: completion)
        }
    }
    
}

// MARK: - Private

private extension PlayerService {
 
    func didGetRecentlyPlayedGames(response: RecentlyPlayedGamesResponse,
                                   completion: ([Game]) -> Void) {
        completion(response.games)
    }
    
    func didGetOwnedGames(response: GetOwnedGamesResponse,
                          completion: ([OwnedGame]) -> Void) {
        completion(response.games)
    }
    
}
