//
//  StatEntityClearRequest.swift
//  Steam
//
//  Created by Ivan Zinovyev on 29/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import CoreData

public extension CoreDataService {
    
    func clear() {
        persistentContainer.performBackgroundTask { context in
            let request: NSFetchRequest<NSFetchRequestResult> = StatEntity.fetchRequest()
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: request)
            context.executeSafely(batchDeleteRequest)
        }
    }
    
}
