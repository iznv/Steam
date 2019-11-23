//
//  TabBarController.swift
//  Steam
//
//  Created by Ivan Zinovyev on 20/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabs()
    }
    
}

// MARK: - Configure Tabs

private extension TabBarController {
    
    func configureTabs() {
        viewControllers = [
            profile,
            activity
        ].map { $0.controller }
    }
    
    // MARK: - Tabs
    
    var activity: Tab {
        return Tab(controller: ActivityViewController(viewModel: .init()).embeddedInNavigation,
                   title: R.string.localizable.activityTabTitle(),
                   image: R.image.activityTabIcon())
    }
    
    var profile: Tab {
        return Tab(controller: ProfileViewController(viewModel: .init()).embeddedInNavigation,
                   title: R.string.localizable.profileTabTitle(),
                   image: R.image.profileTabIcon())
    }
    
}
