//
//  UITabBarItem+Decorations.swift
//  Steam
//
//  Created by Ivan Zinovyev on 29/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import UIKit

extension UITabBarItem {
    
    enum Decorations {
        
        static let `default`: Decoration<UITabBarItem> = {
            $0.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.medium10() as Any], for: .normal)
        }
        
    }
    
}
