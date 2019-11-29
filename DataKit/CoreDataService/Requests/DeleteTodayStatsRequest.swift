//
//  DeleteTodayStatsRequest.swift
//  Steam
//
//  Created by Ivan Zinovyev on 25/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import CoreData
import Utils

public extension CoreDataService {
    
    func deleteTodayStats(for appId: Int,
                          completion: @escaping () -> Void) {
        
        persistentContainer.performBackgroundTask { context in
            let request: NSFetchRequest<NSFetchRequestResult> = StatEntity.fetchRequest()

            var calendar = Calendar.current
            calendar.timeZone = NSTimeZone.local

            let date = Date()
            let dateFrom = calendar.startOfDay(for: date)
            guard let dateTo = calendar.date(byAdding: .day, value: 1, to: dateFrom) else { return }

            let appIdPredicate = NSPredicate(format: "appId = %@", appId as NSObject)
            let fromPredicate = NSPredicate(format: "date >= %@", dateFrom as NSDate)
            let toPredicate = NSPredicate(format: "date < %@", dateTo as NSDate)
            
            let datePredicate = NSCompoundPredicate(type: .and,
                                                    subpredicates: [appIdPredicate, fromPredicate, toPredicate])
            
            request.predicate = datePredicate
            
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: request)

            context.executeSafely(batchDeleteRequest)
            completion()
        }
    }
    
}
