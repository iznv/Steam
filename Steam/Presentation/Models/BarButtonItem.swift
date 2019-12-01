//
//  BarButtonItem.swift
//  Steam
//
//  Created by Ivan Zinovyev on 01/12/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import UIKit

class BarButtonItem: UIBarButtonItem {
    
    // MARK: - Properties
    
    private var actionHandler: (() -> Void)?
    
    // MARK: - Init
    
    convenience init(title: String?,
                     style: UIBarButtonItem.Style,
                     actionHandler: (() -> Void)?) {
        
        self.init(title: title,
                  style: style,
                  target: nil,
                  action: #selector(onTap))
        
        self.target = self
        self.actionHandler = actionHandler
    }
    
    convenience init(image: UIImage?,
                     style: UIBarButtonItem.Style,
                     actionHandler: (() -> Void)?) {
        
        self.init(image: image,
                  style: style,
                  target: nil,
                  action: #selector(onTap))
        
        self.target = self
        self.actionHandler = actionHandler
    }
    
}

// MARK: - Private

private extension BarButtonItem {
    
    @objc func onTap(sender: UIBarButtonItem) {
        actionHandler?()
    }
    
}
