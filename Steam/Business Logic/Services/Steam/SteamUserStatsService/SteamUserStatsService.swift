//
//  SteamUserStatsService.swift
//  Steam
//
//  Created by Ivan Zinovyev on 22/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

class SteamUserStatsService {
    
    func getGlobalAchievementPercentagesForApp(gameId: Int,
                                               completion: @escaping ([GlobalAchievement]) -> Void) {
        
        ApiService.shared.getGlobalAchievementPercentagesForApp(gameId: gameId) {
            completion($0.achievementPercentages.achievements)
        }
    }
    
    func getNumberOfCurrentPlayers(appId: Int,
                                   completion: @escaping (Int) -> Void) {
        
        ApiService.shared.getNumberOfCurrentPlayers(appId: appId) {
            completion($0.response.playerCount ?? 0)
        }
    }
    
    func getPlayerAchievements(steamId: String,
                               appId: Int,
                               completion: @escaping (PlayerAchievementsPlayerStats) -> Void) {
        
        ApiService.shared.getPlayerAchievements(steamId: steamId,
                                                appId: appId) {
            completion($0.playerStats)
        }
    }
    
    func getSchemaForGame(appId: Int,
                          completion: @escaping (AvailableGameStats) -> Void) {
        
        ApiService.shared.getSchemaForGame(appId: appId) {
            completion($0.game.availableGameStats)
        }
    }
    
    func getUserStatsForGame(steamId: String,
                             appId: Int,
                             completion: @escaping (UserStatsForGamePlayerStats?) -> Void) {
        
        ApiService.shared.getUserStatsForGame(steamId: steamId,
                                              appId: appId) {
            completion($0.playerStats)
        }
    }
    
}
