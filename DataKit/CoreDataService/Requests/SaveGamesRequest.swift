//
//  SaveGamesRequest.swift
//  DataKit
//
//  Created by Ivan Zinovyev on 04/12/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import Utils

public extension CoreDataService {
    
    func save(games: [GameDataModel],
              completion: @escaping () -> Void) {
        
        persistentContainer.performBackgroundTask { context in
            games.forEach { game in
                let entity = GameEntity(context: context)
                entity.appId = game.appId
                entity.name = game.name
            }

            context.saveSafely()
            completion()
        }
    }
    
}
