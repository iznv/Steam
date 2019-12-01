//
//  AppCoordinator.swift
//  Steam
//
//  Created by Ivan Zinovyev on 30/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import UIKit

class AppCoordinator {
    
    // MARK: - Child
    
    private let tabCoordinator = TabCoordinator()
    
    // MARK: - Properties
    
    weak var window: UIWindow?
    
    // MARK: - Init
    
    init(window: UIWindow?) {
        self.window = window
    }
    
}

// MARK: - Start

extension AppCoordinator {
    
    func start() {
        window?.rootViewController = tabCoordinator.root
        window?.makeKeyAndVisible()
        
        tabCoordinator.start()
    }
    
}
