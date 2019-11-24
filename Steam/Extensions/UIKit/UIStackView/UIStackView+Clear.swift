//
//  UIStackView+Clear.swift
//  Steam
//
//  Created by Ivan Zinovyev on 24/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import UIKit

extension UIStackView {
    
    func clear() {
        arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
    
}
