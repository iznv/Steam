//
//  GamesCoordinator.swift
//  Steam
//
//  Created by Ivan Zinovyev on 03/12/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import UIKit

class GamesCoordinator {
    
    // MARK: - Children
    
    private var gameCoordinator: GameCoordinator?
    
    // MARK: - Properties
    
    private var navigationController: UINavigationController
    
    var didFinish: (() -> Void)?
    
    // MARK: - Services
    
    private let authService = AuthService()
    
    // MARK: - Init
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

}

// MARK: - Coordinator

extension GamesCoordinator: Coordinator {
    
    var root: UIViewController {
        return navigationController
    }
    
    func start() {
        showGamesScreen()
    }
    
}

// MARK: - Private

private extension GamesCoordinator {
    
    func showGamesScreen() {
        let gamesViewController = GamesViewController(viewModel: .init())
        
        gamesViewController.didTapGame = { [weak self] appId in
            self?.showGameScreen(appId: appId)
        }
        
        navigationController.pushViewController(gamesViewController, animated: false)
    }
    
    func showGameScreen(appId: Int) {
        gameCoordinator = GameCoordinator(navigationController: navigationController,
                                          appId: appId,
                                          steamId: authService.steamId)
        
        gameCoordinator?.didFinish = { [weak self] in
            self?.gameCoordinator = nil
        }
        
        gameCoordinator?.start()
    }

}
