//
//  ProfileCoordinator.swift
//  Steam
//
//  Created by Ivan Zinovyev on 01/12/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import UIKit

class ProfileCoordinator {
    
    // MARK: - Children
    
    private var activityCoordinator: ActivityCoordinator?
    
    private var profileCoordinator: ProfileCoordinator?
    
    private var loginCoordinator: LoginCoordinator?
    
    private var gameCoordinator: GameCoordinator?
    
    // MARK: - Properties
    
    private var navigationController: UINavigationController
    
    private let isRoot: Bool
    
    private var steamId: String?
    
    private var appId: Int?
    
    var didFinish: (() -> Void)?
    
    // MARK: - Init
    
    init(navigationController: UINavigationController,
         isRoot: Bool,
         steamId: String? = nil) {
        
        self.navigationController = navigationController
        self.isRoot = isRoot
        self.steamId = steamId
    }

}

// MARK: - Coordinator

extension ProfileCoordinator: Coordinator {
    
    var root: UIViewController {
        return navigationController
    }
    
    func start() {
        showUserProfileScreen()
    }
    
}

// MARK: - Private

private extension ProfileCoordinator {
    
    func showUserProfileScreen() {
        let profileViewController = ProfileViewController(viewModel: .init(steamId: steamId))
        
        profileViewController.didTapActivity = { [weak self] steamId in
            self?.showActivityScreen()
        }
        
        profileViewController.didTapGames = { [weak self] steamId in
            self?.steamId = steamId
            self?.showGamesScreen()
        }
        
        profileViewController.didTapFriends = { [weak self] steamId in
            self?.steamId = steamId
            self?.showFriendsScreen()
        }
        
        profileViewController.didTapLogin = { [weak self] in
            self?.showLoginScreen()
        }
        
        if !isRoot {
            profileViewController.navigationItem.leftBarButtonItem = makeBackButtonItem(shouldFinishOnTap: true)
        }
        
        navigationController.pushViewController(profileViewController, animated: !isRoot)
    }
    
    func showActivityScreen() {
        activityCoordinator = ActivityCoordinator(navigationController: navigationController,
                                                  isRoot: false,
                                                  gamesType: .recent,
                                                  steamId: steamId)
        
        activityCoordinator?.didFinish = { [weak self] in
            self?.activityCoordinator = nil
        }
        
        activityCoordinator?.start()
    }
    
    func showGamesScreen() {
        let activityViewController = ActivityViewController(viewModel: .init(gamesType: .owned,
                                                                             steamId: steamId))
        
        activityViewController.didSelectGame = { [weak self] appId, steamId in
            self?.appId = appId
            self?.steamId = steamId
            self?.showGameScreen()
        }
        
        activityViewController.navigationItem.leftBarButtonItem = makeBackButtonItem(shouldFinishOnTap: false)
        
        navigationController.pushViewController(activityViewController, animated: true)
    }
    
    func showFriendsScreen() {
        guard let steamId = steamId else { return }
        
        let friendsViewController = FriendsViewController(viewModel: .init(steamId: steamId))
        
        friendsViewController.didSelectFriend = { [weak self] steamId in
            self?.showPlayerScreen(steamId: steamId)
        }
        
        friendsViewController.navigationItem.leftBarButtonItem = makeBackButtonItem(shouldFinishOnTap: false)
        
        navigationController.pushViewController(friendsViewController, animated: true)
    }
    
    func showPlayerScreen(steamId: String) {
        profileCoordinator = ProfileCoordinator(navigationController: navigationController,
                                                isRoot: false,
                                                steamId: steamId)
        
        profileCoordinator?.didFinish = { [weak self] in
            self?.profileCoordinator = nil
        }
        
        profileCoordinator?.start()
    }
    
    func showLoginScreen() {
        loginCoordinator = LoginCoordinator(navigationController: NavigationController())
        
        loginCoordinator?.didFinish = { [weak self] in
            self?.loginCoordinator = nil
        }

        loginCoordinator?.start(presenter: navigationController)
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
    
}
