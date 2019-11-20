//
//  UIViewController+UINavigationController.swift
//  Steam
//
//  Created by Ivan Zinovyev on 20/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import UIKit

extension UIViewController {
    
    var embeddedInNavigation: UIViewController {
        return NavigationController(rootViewController: self)
    }
    
}
