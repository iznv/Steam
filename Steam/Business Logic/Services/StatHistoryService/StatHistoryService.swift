//
//  StatHistoryService.swift
//  Steam
//
//  Created by Ivan Zinovyev on 26/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import ApiKit
import DataKit
import SteamKit

private enum Constants {
    
    static let requestInterval: TimeInterval = 0.5
    
}

class StatHistoryService {
    
    // MARK: - Services
    
    private let authService = AuthService()
    
    private let steamPlayerService = SteamPlayerService()
    
    private let steamUserStatsService = SteamUserStatsService()
    
}

// MARK: - Public

extension StatHistoryService {
    
    func updateHistory() {
        guard let steamId = authService.steamId else { return }
        
        steamPlayerService.getRecentlyPlayedGames(steamId: steamId) { [weak self] result in
            if case let .success(games) = result {
                self?.loadStats(for: games)
            }
        }
    }
    
    func getStatItems(appId: Int,
                      name: String,
                      completion: @escaping ([StatItem]) -> Void) {
        
        CoreDataService.shared.getStats(for: appId, name: name) { stats in
            guard !stats.isEmpty else {
                completion([])
                return
            }
            
            var items = [StatItem]()
            
            for i in 0..<(stats.count - 1) {
                let item = StatItem(dateHistoryString: DateFormatter.common.string(for: stats[i].date) ?? .empty,
                                    dateGraphString: DateFormatter.dayMonth.string(for: stats[i].date) ?? .empty,
                                    value: stats[i].value - stats[i + 1].value)
                items.append(item)
            }
            
            completion(items)
        }
    }
    
}

// MARK: - Private

private extension StatHistoryService {
    
    func loadStats(for games: [PlayerGame]) {
        games.enumerated().forEach { index, game in
            DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + Double(index) * Constants.requestInterval) { [weak self] in
                self?.loadStats(for: game)
            }
        }
    }
    
    func loadStats(for game: PlayerGame) {
        guard let steamId = authService.steamId else { return }
        
        steamUserStatsService.getUserStatsForGame(steamId: steamId,
                                                  appId: game.appId) { [weak self] in
            if case let .success(playerStats) = $0,
               let stats = playerStats?.stats {
                self?.save(stats, for: game.appId)
            }
        }
    }
    
    func save(_ stats: [Stat],
              for appId: Int) {
        
        let date = Date()
        
        let statDataModels = stats.map {
            StatDataModel(appId: Int64(appId),
                          name: $0.name,
                          value: $0.value,
                          date: date)
        }
                
        CoreDataService.shared.deleteTodayStats(for: appId) {
            CoreDataService.shared.add(stats: statDataModels)
        }
    }
    
}
