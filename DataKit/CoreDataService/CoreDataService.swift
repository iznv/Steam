//
//  CoreDataService.swift
//  Steam
//
//  Created by Ivan Zinovyev on 25/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import CoreData

public class CoreDataService {
    
    // MARK: - Singleton
    
    public static let shared = CoreDataService()
    
    private init() {}
    
    // MARK: - Container
    
    lazy var persistentContainer: NSPersistentContainer = {
        let bundle = Bundle(identifier: "com.zinovev.DataKit")
        
        guard let modelUrl = bundle?.url(forResource: "DataModel", withExtension: "momd") else {
            fatalError("No DataModel")
        }
        
        guard let moModel = NSManagedObjectModel(contentsOf: modelUrl) else {
            fatalError("Can't create Managed Object Model")
        }
        
        let container = NSPersistentContainer(name: "DataModel", managedObjectModel: moModel)
        container.loadPersistentStores(completionHandler: { _, _ in })
        return container
    }()
    
}
