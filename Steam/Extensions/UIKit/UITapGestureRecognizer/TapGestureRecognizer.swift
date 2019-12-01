//
//  TapGestureRecognizer.swift
//  Steam
//
//  Created by Ivan Zinovyev on 01/12/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import UIKit

class TapGestureRecognizer: UITapGestureRecognizer {
    
    // MARK: - Properties
    
    private var action: () -> Void

    // MARK: - Init
    
    init(action: @escaping () -> Void) {
        self.action = action
        super.init(target: nil, action: nil)
        
        addTarget(self, action: #selector(execute))
    }

}

// MARK: - UIView+OnTap

extension UIView {
    
    func onTap(closure: @escaping () -> Void) {
        addGestureRecognizer(TapGestureRecognizer(action: closure))
    }
    
}

// MARK: - Private

private extension TapGestureRecognizer {
    
    @objc private func execute() {
        action()
    }
    
}
