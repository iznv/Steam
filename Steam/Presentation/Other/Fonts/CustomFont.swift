//
//  CustomFont.swift
//  Steam
//
//  Created by Ivan Zinovyev on 27/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import UIKit

enum CustomFont {
    
    static let quicksand = "Quicksand"
    
}

private enum Constants {
    
    static let selectedFont = CustomFont.quicksand
    
}

extension UIFont {
    
    static func bold17() -> UIFont? {
        return .custom(font: Constants.selectedFont, ofSize: 17, weight: .bold)
    }
    
    static func bold16() -> UIFont? {
        return .custom(font: Constants.selectedFont, ofSize: 16, weight: .bold)
    }
    
    static func medium26() -> UIFont? {
        return .custom(font: Constants.selectedFont, ofSize: 26, weight: .medium)
    }
    
    static func medium20() -> UIFont? {
        return .custom(font: Constants.selectedFont, ofSize: 20, weight: .medium)
    }
    
    static func medium16() -> UIFont? {
        return .custom(font: Constants.selectedFont, ofSize: 16, weight: .medium)
    }
    
    static func medium14() -> UIFont? {
        return .custom(font: Constants.selectedFont, ofSize: 14, weight: .medium)
    }
    
    static func medium12() -> UIFont? {
        return .custom(font: Constants.selectedFont, ofSize: 12, weight: .medium)
    }
    
    static func medium10() -> UIFont? {
        return .custom(font: Constants.selectedFont, ofSize: 10, weight: .medium)
    }
    
}
