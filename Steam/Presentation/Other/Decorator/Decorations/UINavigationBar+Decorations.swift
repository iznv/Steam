//
//  UINavigationBar+Decorations.swift
//  Steam
//
//  Created by Ivan Zinovyev on 29/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import UIKit

extension UINavigationBar {
    
    enum Decorations {
        
        static let `default`: Decoration<UINavigationBar> = {
            $0.isTranslucent = false
            $0.setBackgroundImage(UIImage(), for: .default)
            $0.shadowImage = UIImage()
        }
        
    }
    
}
