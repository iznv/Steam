//
//  GetGamesRequest.swift
//  DataKit
//
//  Created by Ivan Zinovyev on 04/12/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import CoreData

public extension CoreDataService {
    
    func getGames(query: String? = nil,
                  count: Int = 100,
                  offset: Int = 0,
                  completion: @escaping (([GameDataModel]) -> Void)) {
        
        persistentContainer.performBackgroundTask { context in
            let request: NSFetchRequest<GameEntity> = GameEntity.fetchRequest()
            
            request.fetchLimit = count
            request.fetchOffset = offset
            
            var predicates = [NSPredicate]()

            if let query = query, !query.isEmpty {
                predicates.append(NSPredicate(format: "%K BEGINSWITH[c] %@", #keyPath(GameEntity.name), query))
            }
            
            request.predicate = NSCompoundPredicate(type: .and, subpredicates: predicates)
            request.sortDescriptors = [NSSortDescriptor(key: #keyPath(GameEntity.name), ascending: true)]
            
            let result = context.fetchSafely(request) ?? []
            
            let games: [GameDataModel] = result.compactMap { game in
                guard let name = game.name else { return nil }
                return GameDataModel(appId: game.appId, name: name)
            }
            
            completion(games)
        }
    }
    
}
