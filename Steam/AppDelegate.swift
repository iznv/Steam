//
//  AppDelegate.swift
//  Steam
//
//  Created by Ivan Zinovyev on 19/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder {
    
    // MARK: - Properties

    lazy var window: UIWindow? = Window(frame: UIScreen.main.bounds)
    
    // MARK: - Services

    private let statHistoryService = StatHistoryService()
    
    private lazy var appCoordinator = AppCoordinator(window: window)

}

// MARK: - UIApplicationDelegate

extension AppDelegate: UIApplicationDelegate {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        configureAppearance()
        
        appCoordinator.start()
        
        statHistoryService.updateHistory()
        
        return true
    }
    
}

// MARK: - Appearance

private extension AppDelegate {
    
    func configureAppearance() {
        UINavigationBar.appearance().decorator.apply(UINavigationBar.Decorations.default)
        UITabBar.appearance().decorator.apply(UITabBar.Decorations.default)
        UITabBarItem.appearance().decorator.apply(UITabBarItem.Decorations.default)
    }
    
}
