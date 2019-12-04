//
//  LightTheme.swift
//  Steam
//
//  Created by Ivan Zinovyev on 27/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import UIKit

class LightTheme: Theme {
    
    let primaryTextColor = UIColor(hex: 0x000000)
    
    let primaryBackgroundColor = UIColor(hex: 0xF4F4F4)
    
    let secondaryBackgroundColor = UIColor(hex: 0x000000).withAlphaComponent(0.1)
    
    let accentColor = UIColor(hex: 0xFFB700)
    
    let statusBarStyle = UIStatusBarStyle.default
    
    let activityIndicatorStyle = UIActivityIndicatorView.Style.gray
    
    let keyboardAppearance = UIKeyboardAppearance.light
    
}
