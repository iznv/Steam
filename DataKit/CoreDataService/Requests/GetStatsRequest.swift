//
//  GetStatsRequest.swift
//  Steam
//
//  Created by Ivan Zinovyev on 25/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import CoreData

public extension CoreDataService {
    
    func getStats(for appId: Int,
                  name: String? = nil,
                  completion: @escaping (([StatDataModel]) -> Void)) {
        
        persistentContainer.performBackgroundTask { context in
            let request: NSFetchRequest<StatEntity> = StatEntity.fetchRequest()
            
            var predicates = [NSPredicate]()
            predicates.append(NSPredicate(format: "%K = %@", #keyPath(StatEntity.appId), appId as NSObject))
            
            if let name = name {
                predicates.append(NSPredicate(format: "%K = %@", #keyPath(StatEntity.name), name))
            }
            
            request.predicate = NSCompoundPredicate(type: .and, subpredicates: predicates)
            request.sortDescriptors = [NSSortDescriptor(key: #keyPath(StatEntity.date), ascending: false)]
            
            let result = context.fetchSafely(request) ?? []
            
            let stats: [StatDataModel] = result.compactMap { stat in
                guard let name = stat.name else { return nil }
                guard let date = stat.date else { return nil }
                
                return StatDataModel(appId: stat.appId,
                                     name: name,
                                     value: stat.value,
                                     date: date)
            }
            
            completion(stats)
        }
    }
    
}
