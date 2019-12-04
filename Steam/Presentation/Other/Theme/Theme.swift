//
//  Theme.swift
//  Steam
//
//  Created by Ivan Zinovyev on 27/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import UIKit

protocol Theme {
    
    var primaryTextColor: UIColor { get }
    
    var primaryBackgroundColor: UIColor { get }
    
    var secondaryBackgroundColor: UIColor { get }
    
    var accentColor: UIColor { get }
    
    var statusBarStyle: UIStatusBarStyle { get }
    
    var activityIndicatorStyle: UIActivityIndicatorView.Style { get }
    
    var keyboardAppearance: UIKeyboardAppearance { get }
    
}
