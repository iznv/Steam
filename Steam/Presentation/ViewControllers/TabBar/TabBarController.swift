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
        
        enableTheme(for: tabBar, shouldUpdateLayout: true)
    }
    
}

// MARK: - Themeable

extension TabBarController: Themeable {
    
    func apply(theme: Theme) {
        view.backgroundColor = theme.primaryBackgroundColor
        tabBar.barTintColor = theme.primaryBackgroundColor
        tabBar.tintColor = theme.primaryTextColor
        tabBar.unselectedItemTintColor = theme.primaryTextColor.withAlphaComponent(0.4)
    }
    
}
