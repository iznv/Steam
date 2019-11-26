//
//  AddStatsRequest.swift
//  Steam
//
//  Created by Ivan Zinovyev on 25/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import Foundation

extension CoreDataService {
    
    func add(stats: [Stat],
             for appId: Int) {
        
        persistentContainer.performBackgroundTask { context in
            let date = Date()
            
            stats.forEach { stat in
                let entity = StatEntity(context: context)
                entity.appId = Int64(appId)
                entity.name = stat.name
                entity.value = stat.value
                entity.date = date
            }

            context.saveSafely()
        }
    }
    
}
