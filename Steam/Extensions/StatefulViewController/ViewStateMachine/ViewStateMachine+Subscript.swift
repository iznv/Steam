//
//  ViewStateMachine+Subscript.swift
//  Steam
//
//  Created by Ivan Zinovyev on 23/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import StatefulViewController

extension ViewStateMachine {

    subscript<T: RawRepresentable>(state: T) -> UIView? where T.RawValue == String {
        get {
            return self[state.rawValue]
        }
        set(newValue) {
            self[state.rawValue] = newValue
        }
    }

}
