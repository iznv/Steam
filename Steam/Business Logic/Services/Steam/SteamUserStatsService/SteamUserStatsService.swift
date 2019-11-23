//
//  SteamUserStatsService.swift
//  Steam
//
//  Created by Ivan Zinovyev on 22/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

class SteamUserStatsService {
    
    func getGlobalAchievementPercentagesForApp(gameId: Int,
                                               completion: @escaping (Result<[GlobalAchievement], ApiService.Error>) -> Void) {
        
        ApiService.shared.getGlobalAchievementPercentagesForApp(gameId: gameId) {
            completion($0.map { $0.achievementPercentages.achievements })
        }
    }
    
    func getNumberOfCurrentPlayers(appId: Int,
                                   completion: @escaping (Result<Int, ApiService.Error>) -> Void) {
        
        ApiService.shared.getNumberOfCurrentPlayers(appId: appId) {
            completion($0.map { $0.response.playerCount ?? 0 })
        }
    }
    
    func getPlayerAchievements(steamId: String,
                               appId: Int,
                               completion: @escaping (Result<PlayerAchievementsPlayerStats, ApiService.Error>) -> Void) {
        
        ApiService.shared.getPlayerAchievements(steamId: steamId,
                                                appId: appId) {
            completion($0.map { $0.playerStats })
        }
    }
    
    func getSchemaForGame(appId: Int,
                          completion: @escaping (Result<AvailableGameStats, ApiService.Error>) -> Void) {
        
        ApiService.shared.getSchemaForGame(appId: appId) {
            completion($0.map { $0.game.availableGameStats })
        }
    }
    
    func getUserStatsForGame(steamId: String,
                             appId: Int,
                             completion: @escaping (Result<UserStatsForGamePlayerStats?, ApiService.Error>) -> Void) {
        
        ApiService.shared.getUserStatsForGame(steamId: steamId,
                                              appId: appId) {
            completion($0.map { $0.playerStats })
        }
    }
    
}
