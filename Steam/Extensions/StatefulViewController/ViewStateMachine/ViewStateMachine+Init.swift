//
//  ViewStateMachine+Init.swift
//  Steam
//
//  Created by Ivan Zinovyev on 23/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import StatefulViewController

extension ViewStateMachine {

    convenience init(view: UIView,
                     defaultStatesDelegate: DefaultStatesDelegate?) {

        var states = [String: UIView]()

        ViewState.allCases.forEach { state in
            if let stateView = state.makeDefaultView(delegate: defaultStatesDelegate) {
                states[state.rawValue] = stateView
            }
        }

        self.init(view: view, states: states)
    }

}
