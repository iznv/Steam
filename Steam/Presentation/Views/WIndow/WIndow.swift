//
//  WIndow.swift
//  Steam
//
//  Created by Ivan Zinovyev on 04/12/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import UIKit

class Window: UIWindow {
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        enableTheme(for: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Themeable

extension Window: Themeable {
    
    func apply(theme: Theme) {
        backgroundColor = theme.primaryBackgroundColor
    }
    
}
