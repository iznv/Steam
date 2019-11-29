//
//  AddStatsRequest.swift
//  Steam
//
//  Created by Ivan Zinovyev on 25/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import Utils

public extension CoreDataService {
    
    func add(stats: [StatDataModel]) {
        
        persistentContainer.performBackgroundTask { context in
            stats.forEach { stat in
                let entity = StatEntity(context: context)
                entity.appId = stat.appId
                entity.name = stat.name
                entity.value = stat.value
                entity.date = stat.date
            }

            context.saveSafely()
        }
    }
    
}
