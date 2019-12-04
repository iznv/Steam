//
//  CustomLoadingIndicator.swift
//  Steam
//
//  Created by Ivan Zinovyev on 04/12/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import UIKit

class CustomLoadingIndicator: UIActivityIndicatorView {
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        enableTheme(for: self)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Themeable

extension CustomLoadingIndicator: Themeable {
    
    func apply(theme: Theme) {
        style = theme.activityIndicatorStyle
    }
    
}
