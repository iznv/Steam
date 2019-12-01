//
//  StatisticsCoordinator.swift
//  Steam
//
//  Created by Ivan Zinovyev on 01/12/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import ApiKit
import UIKit

class StatisticsCoordinator {
    
    // MARK: - Properties
    
    var navigationController: UINavigationController
    
    private let appId: Int
    
    private let steamId: String
    
    private var schemaAchievements: [SchemaAchievement]?
    
    private var schemaStats: [SchemaStat]?
    
    private var achievements: [Achievement]?
    
    private var stats: [Stat]?
    
    private var statisticsProvider: CustomStatisticsProvider?
    
    var didFinish: (() -> Void)?
    
    // MARK: - Computed Properties
    
    private var canCompare: Bool {
        return authService.steamId != steamId
    }
    
    // MARK: - Services
    
    private let authService = AuthService()
    
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

extension StatisticsCoordinator: Coordinator {
    
    var root: UIViewController {
        return navigationController
    }

    func start() {
        showStatisticsScreen()
    }
    
}

// MARK: - Private

private extension StatisticsCoordinator {
    
    func showStatisticsScreen() {
        let statisticsViewController = StatisticsViewController(viewModel: .init(appId: appId,
                                                                                 steamId: steamId))
        
        statisticsViewController.didTapAchievements = { [weak self] schemaAchievements, achievements in
            guard let self = self else { return }
            self.schemaAchievements = schemaAchievements
            self.achievements = achievements
            self.showAchievementsScreen(schemaAchievements: schemaAchievements,
                                        achievements: achievements)
        }
        
        statisticsViewController.didTapStats = { [weak self] schemaStats, stats in
            guard let self = self else { return }
            self.schemaStats = schemaStats
            self.stats = stats
            self.showStatsScreen()
        }
        
        statisticsViewController.navigationItem.leftBarButtonItem = makeBackButtonItem(shouldFinishOnTap: true)
        
        navigationController.pushViewController(statisticsViewController, animated: true)
    }
    
    func showAchievementsScreen(schemaAchievements: [SchemaAchievement],
                                achievements: [Achievement]) {
        
        let achievementsViewController = AchievementsViewController(viewModel: .init(steamId: steamId,
                                                                                     schemaAchievements: schemaAchievements,
                                                                                     achievements: achievements))
        
        if canCompare {
            achievementsViewController.navigationItem.rightBarButtonItem = BarButtonItem(image: R.image.compareBarButton(),
                                                                                         style: .plain) { [weak self] in
                self?.showAchievementsCompareScreen()
            }
        }
        
        achievementsViewController.navigationItem.leftBarButtonItem = makeBackButtonItem(shouldFinishOnTap: false)
        
        navigationController.pushViewController(achievementsViewController, animated: true)
    }
    
    func showStatsScreen() {
        if let provider = customStatisticsProvider {
            showCustomStatisticsScreen(provider: provider)
        } else {
            showGeneralStatisticsScreen()
        }
    }
    
    func showCustomStatisticsScreen(provider: CustomStatisticsProvider) {
        let customStatsViewController = CustomStatsViewController(viewModel: .init(stats: provider.statistics))
        
        customStatsViewController.didSelectAll = { [weak self] in
            self?.showGeneralStatisticsScreen()
        }
        
        if canCompare {
            customStatsViewController.navigationItem.rightBarButtonItem
                = BarButtonItem(image: R.image.compareBarButton(),
                                  style: .plain) { [weak self] in
                self?.showStatsCompareScreen()
            }
        }
        
        customStatsViewController.navigationItem.leftBarButtonItem = makeBackButtonItem(shouldFinishOnTap: false)
        
        navigationController.pushViewController(customStatsViewController, animated: true)
    }
    
    func showGeneralStatisticsScreen() {
        guard let schemaStats = schemaStats else { return }
        guard let stats = stats else { return }
        
        let statsViewController = StatsViewController(viewModel: .init(steamId: steamId,
                                                                       schemaStats: schemaStats,
                                                                       stats: stats))
        
        statsViewController.didSelectStat = { [weak self] statName in
            self?.onStatSelect(name: statName)
        }

        if canCompare {
            statsViewController.navigationItem.rightBarButtonItem
                = BarButtonItem(image: R.image.compareBarButton(),
                                  style: .plain) { [weak self] in
                self?.showStatsCompareScreen()
            }
        }
        
        statsViewController.navigationItem.leftBarButtonItem = makeBackButtonItem(shouldFinishOnTap: false)
        
        navigationController.pushViewController(statsViewController, animated: true)
    }
    
    func showAchievementsCompareScreen() {
        guard let schemaAchievements = schemaAchievements else { return }
        guard let achievements = achievements else { return }
        
        let achievementCompareViewController = AchievementCompareViewController(viewModel: .init(
            appId: appId,
            schemaAchievements: schemaAchievements,
            achievements: achievements)
        )

        achievementCompareViewController.navigationItem.leftBarButtonItem = makeBackButtonItem(shouldFinishOnTap: false)
        
        navigationController.pushViewController(achievementCompareViewController, animated: true)
    }
    
    func showStatsCompareScreen() {
        guard let schemaStats = schemaStats else { return }
        guard let stats = stats else { return }
        
        let statCompareViewController = StatCompareViewController(viewModel: .init(appId: appId,
                                                                                   schemaStats: schemaStats,
                                                                                   stats: stats))
        
        statCompareViewController.navigationItem.leftBarButtonItem = makeBackButtonItem(shouldFinishOnTap: false)
        
        navigationController.pushViewController(statCompareViewController, animated: true)
    }
    
    func showStatHistoryScreen(statName: String) {
        let statHistoryViewController = StatHistoryViewController(viewModel: .init(appId: appId,
                                                                                   statName: statName))
        
        statHistoryViewController.navigationItem.leftBarButtonItem = makeBackButtonItem(shouldFinishOnTap: false)

        navigationController.pushViewController(statHistoryViewController, animated: true)
    }
    
}

// MARK: - Utils

private extension StatisticsCoordinator {
    
    func onStatSelect(name: String) {
        if authService.steamId == steamId {
            showStatHistoryScreen(statName: name)
        }
    }
    
    var customStatisticsProvider: CustomStatisticsProvider? {
        guard let stats = stats else { return nil }
        
        switch appId {
        case 578080:
            statisticsProvider = PubgStatisticsProvider(stats: stats) { [weak self] in
                self?.onStatSelect(name: $0)
            }
            return statisticsProvider
        default:
            return nil
        }
    }

}
