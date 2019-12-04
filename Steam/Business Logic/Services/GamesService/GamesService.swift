//
//  GamesService.swift
//  Steam
//
//  Created by Ivan Zinovyev on 04/12/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import ApiKit
import DataKit

class GamesService {
    
    func save(games: [App],
              _ completion: @escaping () -> Void) {
        
        let gamesDataModels = games
            .map {
                GameDataModel(appId: Int64($0.appid),
                              name: $0.name.trimmingCharacters(in: .whitespacesAndNewlines))
            }
        
        CoreDataService.shared.save(games: gamesDataModels,
                                    completion: completion)
    }
    
    func getGames(query: String? = nil,
                  count: Int = 100,
                  offset: Int = 0,
                  completion: @escaping ([GameDataModel]) -> Void) {
        
        CoreDataService.shared.getGames(query: query,
                                        count: count,
                                        offset: offset,
                                        completion: completion)
    }
    
}
