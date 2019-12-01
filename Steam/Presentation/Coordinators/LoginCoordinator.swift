//
//  LoginCoordinator.swift
//  Steam
//
//  Created by Ivan Zinovyev on 01/12/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import UIKit

class LoginCoordinator {
    
    // MARK: - Properties
    
    private var navigationController: UINavigationController
    
    var didFinish: (() -> Void)?
    
    // MARK: - Init
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
}

// MARK: - Coordinator

extension LoginCoordinator: Coordinator {
    
    var root: UIViewController {
        return navigationController
    }
    
    func start() {
        showLoginScreen()
    }
    
}

// MARK: - Private

private extension LoginCoordinator {
    
    func showLoginScreen() {
        let loginViewController = LoginViewController(viewModel: .init())
        
        loginViewController.navigationItem.rightBarButtonItem = BarButtonItem(image: R.image.closeBarButton(),
                                                                              style: .plain) { [weak self] in
            loginViewController.dismiss(animated: true, completion: nil)
            self?.didFinish?()
        }
        
        loginViewController.didLogin = { [weak self] in
            self?.navigationController.dismiss(animated: true, completion: nil)
            self?.didFinish?()
        }
        
        navigationController.pushViewController(loginViewController, animated: false)
    }
    
}
