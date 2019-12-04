//
//  NavigationController.swift
//  Steam
//
//  Created by Ivan Zinovyev on 20/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        enableTheme(for: navigationBar, shouldUpdateLayout: true)
        bind()

        configureAppearance()
    }
    
    // MARK: - Overrides

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return ThemeManager.theme.statusBarStyle
    }
    
}

// MARK: - Themeable

extension NavigationController: Themeable {
    
    func apply(theme: Theme) {
        setNeedsStatusBarAppearanceUpdate()
        
        view.backgroundColor = theme.primaryBackgroundColor
        
        navigationBar.barTintColor = theme.primaryBackgroundColor
        navigationBar.tintColor = theme.primaryTextColor
        
        navigationBar.titleTextAttributes = [
            .foregroundColor: theme.primaryTextColor,
            .font: UIFont.bold17() as Any
        ]
    }
    
}

// MARK: - UIGestureRecognizerDelegate

extension NavigationController: UIGestureRecognizerDelegate { }

// MARK: - UINavigationControllerDelegate

extension NavigationController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController,
                              didShow viewController: UIViewController,
                              animated: Bool) {
        
        interactivePopGestureRecognizer?.isEnabled = viewControllers.count > 1
    }
    
}

// MARK: - Private

private extension NavigationController {
    
    func bind() {
        interactivePopGestureRecognizer?.delegate = self
        delegate = self
    }
    
    func configureAppearance() {
        
    }
    
}
