//
//  TabCoordinator.swift
//  Steam
//
//  Created by Ivan Zinovyev on 30/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import UIKit

class TabCoordinator {
    
    // MARK: - Children
    
    private let tabCoordinators: [Coordinator]
    
    // MARK: - Properties
    
    private let tabBarController = TabBarController()
    
    var didFinish: (() -> Void)?
    
    // MARK: - Tabs
    
    private let gamesTabItem = UITabBarItem(title: R.string.localizable.gamesTabTitle(),
                                            image: R.image.tabIconGames(),
                                            selectedImage: nil)
    
    private let activityTabItem = UITabBarItem(title: R.string.localizable.activityTabTitle(),
                                               image: R.image.tabIconActivity(),
                                               selectedImage: nil)
    
    private let profileTabItem = UITabBarItem(title: R.string.localizable.profileTabTitle(),
                                              image: R.image.tabIconProfile(),
                                              selectedImage: nil)
    
    // MARK: - Init
    
    init() {
        tabCoordinators = [
            TabCoordinator.makeGamesCoordinator(tabItem: gamesTabItem),
            TabCoordinator.makeActivityCoordinator(tabItem: activityTabItem),
            TabCoordinator.makeProfileCoordinator(tabItem: profileTabItem)
        ]

        tabBarController.viewControllers = tabCoordinators.map { $0.root }
    }
    
}

// MARK: - Coordinator

extension TabCoordinator: Coordinator {
    
    var root: UIViewController {
        return tabBarController
    }
    
    func start() {
        tabCoordinators.forEach { $0.start() }
    }
    
}

// MARK: - Private

private extension TabCoordinator {
    
    static func makeGamesCoordinator(tabItem: UITabBarItem) -> Coordinator {
        let gamesCoordinator = GamesCoordinator(navigationController: NavigationController())
        gamesCoordinator.root.tabBarItem = tabItem
        return gamesCoordinator
    }
    
    static func makeActivityCoordinator(tabItem: UITabBarItem) -> Coordinator {
        let activityCoordinator = ActivityCoordinator(navigationController: NavigationController(),
                                                      isRoot: true,
                                                      gamesType: .recent)
        activityCoordinator.root.tabBarItem = tabItem
        return activityCoordinator
    }
    
    static func makeProfileCoordinator(tabItem: UITabBarItem) -> Coordinator {
        let profileCoordinator = ProfileCoordinator(navigationController: NavigationController(),
                                                    isRoot: true)
        profileCoordinator.root.tabBarItem = tabItem
        return profileCoordinator
    }
    
}
