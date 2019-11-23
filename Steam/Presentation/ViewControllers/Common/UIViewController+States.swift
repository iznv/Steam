//
//  UIViewController+States.swift
//  Steam
//
//  Created by Ivan Zinovyev on 23/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import StatefulViewController
import UIKit

extension UIViewController {
    
    func bind(_ viewModel: BaseControllerViewModel,
              to stateMachine: ViewStateMachine) {
        
        viewModel.didHappenSomethingWrongError = {
            stateMachine.transition(to: ViewState.somethingWrong)
        }
        
        viewModel.didHappenNoConnectionError = {
            stateMachine.transition(to: ViewState.noConnection)
        }
    }
    
}
