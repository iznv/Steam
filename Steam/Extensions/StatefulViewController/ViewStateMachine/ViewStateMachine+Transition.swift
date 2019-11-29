//
//  ViewStateMachine+Transition.swift
//  Steam
//
//  Created by Ivan Zinovyev on 23/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import StatefulViewController

extension ViewStateMachine {

    func transition<T: RawRepresentable>(to state: T,
                                         animated: Bool = true,
                                         completion: (() -> Void)? = nil) where T.RawValue == String {

        transitionToState(.view(ViewState.transition.rawValue)) { [weak self] in
            self?.transitionToState(.view(state.rawValue), animated: animated, completion: completion)
        }
    }

    func transition(to state: ViewStateMachineState,
                    animated: Bool = true,
                    completion: (() -> Void)? = nil) {

        transitionToState(.view(ViewState.transition.rawValue)) { [weak self] in
            self?.transitionToState(state, animated: animated, completion: completion)
        }
    }

}
