//
//  UITabBar+Decorations.swift
//  Steam
//
//  Created by Ivan Zinovyev on 29/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import UIKit

extension UITabBar {
    
    enum Decorations {
        
        static let `default`: Decoration<UITabBar> = {
            $0.isTranslucent = false
            $0.clipsToBounds = true
        }
        
    }
    
}
