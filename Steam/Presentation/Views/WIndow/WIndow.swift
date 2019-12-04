//
//  WIndow.swift
//  Steam
//
//  Created by Ivan Zinovyev on 04/12/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import UIKit

class Window: UIWindow {

    // MARK: - Overrides
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        guard #available(iOS 13.0, *) else { return }

        switch traitCollection.userInterfaceStyle {
        case .dark:
            ThemeManager.applyDark()
        case .light:
            ThemeManager.applyLight()
        default:
            return
        }
    }
    
}
