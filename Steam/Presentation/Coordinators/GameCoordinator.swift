//
//  GameCoordinator.swift
//  Steam
//
//  Created by Ivan Zinovyev on 01/12/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import UIKit

class GameCoordinator {
    
    // MARK: - Children
    
    private var statisticsCoordinator: StatisticsCoordinator?
    
    // MARK: - Properties
    
    private var navigationController: UINavigationController
    
    private let appId: Int
    
    private let steamId: String
    
    var didFinish: (() -> Void)?
    
    // MARK: - Init
    
    init(navigationController: UINavigationController,
         appId: Int,
         steamId: String) {
        
        self.navigationController = navigationController
        self.appId = appId
        self.steamId = steamId
    }
    
}

// MARK: - Coordinator

extension GameCoordinator: Coordinator {
    
    var root: UIViewController {
        return navigationController
    }
    
    func start() {
        showGameScreen()
    }
    
}

// MARK: - Private

private extension GameCoordinator {
    
    func showGameScreen() {
        let gameViewController = GameViewController(viewModel: .init(appId: appId))
        
        gameViewController.didTapNews = { [weak self] in
            self?.showNewsFeedScreen()
        }
        
        gameViewController.navigationItem.rightBarButtonItem = BarButtonItem(image: R.image.statisticsBarButton(),
                                                                             style: .plain) { [weak self] in
            self?.showStatisticsScreen()
        }
        
        gameViewController.navigationItem.leftBarButtonItem = makeBackButtonItem(shouldFinishOnTap: true)
        
        navigationController.pushViewController(gameViewController, animated: true)
    }
    
    func showStatisticsScreen() {
        statisticsCoordinator = StatisticsCoordinator(navigationController: navigationController,
                                                      appId: appId,
                                                      steamId: steamId)
        
        statisticsCoordinator?.didFinish = { [weak self] in
            self?.statisticsCoordinator = nil
        }
        
        statisticsCoordinator?.start()
    }
    
    func showNewsFeedScreen() {
        let gameNewsViewController = GameNewsViewController(viewModel: .init(appId: appId))
        
        gameNewsViewController.didTapArticle = { [weak self] title, htmlContents in
            self?.showNewsFullScreen(title: title, htmlContents: htmlContents)
        }
        
        gameNewsViewController.navigationItem.leftBarButtonItem = makeBackButtonItem(shouldFinishOnTap: false)
        
        navigationController.pushViewController(gameNewsViewController, animated: true)
    }
    
    func showNewsFullScreen(title: String,
                            htmlContents: String) {
        
        let articleViewController = WebViewViewController(viewModel: .init(title: title,
                                                                           contents: htmlContents))
        
        articleViewController.navigationItem.leftBarButtonItem = makeBackButtonItem(shouldFinishOnTap: false)
        
        navigationController.pushViewController(articleViewController, animated: true)
    }
    
}
