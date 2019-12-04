//
//  ActivityCoordinator.swift
//  Steam
//
//  Created by Ivan Zinovyev on 30/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import UIKit

class ActivityCoordinator {
    
    // MARK: - Children
    
    private var loginCoordinator: LoginCoordinator?
    
    private var gameCoordinator: GameCoordinator?
    
    // MARK: - Properties
    
    private var navigationController: UINavigationController
    
    private let isRoot: Bool
    
    private let gamesType: GamesType
    
    private var steamId: String?
    
    private var appId: Int?
    
    var didFinish: (() -> Void)?
    
    // MARK: - Init
    
    init(navigationController: UINavigationController,
         isRoot: Bool,
         gamesType: GamesType,
         steamId: String? = nil) {

        self.navigationController = navigationController
        self.isRoot = isRoot
        self.gamesType = gamesType
        self.steamId = steamId
    }
    
}

// MARK: - Coordinator

extension ActivityCoordinator: Coordinator {
    
    var root: UIViewController {
        return navigationController
    }
    
    func start() {
        showActivityScreen()
    }
    
}

// MARK: - Private

private extension ActivityCoordinator {
    
    func showActivityScreen() {
        let activityViewController = ActivityViewController(viewModel: .init(gamesType: gamesType,
                                                                             steamId: steamId))
        
        activityViewController.didSelectGame = { [weak self] appId, steamId in
            self?.appId = appId
            self?.steamId = steamId
            self?.showGameScreen()
        }
        
        activityViewController.didTapLogin = { [weak self] in
            self?.showLoginScreen()
        }
        
        if !isRoot {
            activityViewController.navigationItem.leftBarButtonItem = makeBackButtonItem(shouldFinishOnTap: true)
        }
        
        navigationController.pushViewController(activityViewController, animated: !isRoot)
    }
    
    func showGameScreen() {
        guard let appId = appId else { return }
        guard let steamId = steamId else { return }

        gameCoordinator = GameCoordinator(navigationController: navigationController,
                                          appId: appId,
                                          steamId: steamId)
        
        gameCoordinator?.didFinish = { [weak self] in
            self?.gameCoordinator = nil
        }
        
        gameCoordinator?.start()
    }
    
    func showLoginScreen() {
        loginCoordinator = LoginCoordinator(navigationController: NavigationController())
        
        loginCoordinator?.didFinish = { [weak self] in
            self?.loginCoordinator = nil
        }
        
        loginCoordinator?.start(presenter: navigationController)
    }
    
}
