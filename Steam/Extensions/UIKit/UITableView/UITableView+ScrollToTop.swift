//
//  UITableView+ScrollToTop.swift
//  Steam
//
//  Created by Ivan Zinovyev on 04/12/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import UIKit

extension UITableView {
    
    func scrollToTopImmediately() {
        layoutIfNeeded()
        contentOffset = .zero
    }
    
}
