//
//  CoreDataService.swift
//  Steam
//
//  Created by Ivan Zinovyev on 25/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import CoreData

class CoreDataService {
    
    // MARK: - Singleton
    
    static let shared = CoreDataService()
    
    private init() {}
    
    // MARK: - Container
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores(completionHandler: { _, _ in })
        return container
    }()
    
}
