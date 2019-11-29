//
//  CurrencyView.swift
//  ShotOne
//
//  Created by Ivan Zinovyev on 25/03/2019.
//  Copyright © 2019 Ivan Zinovyev. All rights reserved.
//

import Utils

class TransitionStateView: BaseView {

    // MARK: - Init
    
    override func commonInit() {
        super.commonInit()
        
        enableTheme(for: self)
    }
    
}

// MARK: - Themeable

extension TransitionStateView: Themeable {
    
    func apply(theme: Theme) {
        backgroundColor = theme.primaryBackgroundColor
    }
    
}
