//
//  PlayerService.swift
//  Steam
//
//  Created by Ivan Zinovyev on 20/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import ApiKit

private enum Constants {
    
    static let imageUrlFormat = "http://media.steampowered.com/steamcommunity/public/images/apps/%@/%@.jpg"
    
}

public class SteamPlayerService {
    
    public init() { }
    
}

public extension SteamPlayerService {
    
    func getRecentlyPlayedGames(steamId: String,
                                completion: @escaping (Result<[PlayerGame], ApiService.Error>) -> Void) {
        
        ApiService.shared.getRecentlyPlayedGames(steamId: steamId) {
            completion($0.map { $0.response.games?.convertingToPlayerGames() ?? [] })
        }
    }
    
    func getOwnedGames(steamId: String,
                       completion: @escaping (Result<[PlayerGame], ApiService.Error>) -> Void) {
        
        ApiService.shared.getOwnedGames(steamId: steamId) {
            completion(
                $0.map {
                    $0.response.games?
                        .sorted { $0.name ?? .empty < $1.name ?? .empty }
                        .convertingToPlayerGames() ?? []
                }
            )
        }
    }
    
    func getBadges(steamId: String,
                   completion: @escaping (Result<BadgesResponse, ApiService.Error>) -> Void) {
        
        ApiService.shared.getBadges(steamId: steamId) {
            completion($0.map { $0.response })
        }
    }
    
}

// MARK: - Private

private extension Array where Element == Game {
    
    func convertingToPlayerGames() -> [PlayerGame] {
        return compactMap { game in
            guard let name = game.name else { return nil }
            guard let imgLogoURL = game.imgLogoURL else { return nil }
            
            let iconUrl = String(format: Constants.imageUrlFormat,
                                 String(game.appId),
                                 imgLogoURL)
            
            return PlayerGame(appId: game.appId,
                              iconUrl: iconUrl,
                              title: name,
                              lastTwoWeekMinutesPlayed: game.playtime2Weeks,
                              onRecordMinutesPlayed: game.playtimeForever)
        }
    }
    
}
