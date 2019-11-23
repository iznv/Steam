//
//  UIView+Animation.swift
//  Steam
//
//  Created by Ivan Zinovyev on 23/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import UIKit

private enum Constants {

    static let animationDuration = 0.3
}

extension UIView {

    func crossDissolveTransition(closure: @escaping () -> Void) {
        crossDissolveTransition(closure: closure, completion: nil)
    }

    func crossDissolveTransition(closure: @escaping () -> Void,
                                 completion: (() -> Void)? = nil) {
        
        UIView.transition(with: self,
                          duration: Constants.animationDuration,
                          options: .transitionCrossDissolve,
                          animations: closure) { _ in
            completion?()
        }
    }

}
