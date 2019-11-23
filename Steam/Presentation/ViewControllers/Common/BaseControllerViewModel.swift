//
//  BaseControllerViewModel.swift
//  Steam
//
//  Created by Ivan Zinovyev on 23/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

class BaseControllerViewModel {
    
    // MARK: - Properties
    
    var didHappenSomethingWrongError: (() -> Void)?
    
    var didHappenNoConnectionError: (() -> Void)?
    
}

// MARK: - Public

extension BaseControllerViewModel {
    
    func handle(_ error: Error) {
        if let error = error as? ApiService.Error {
            switch error {
            case .noConnection:
                didHappenNoConnectionError?()
            default:
                didHappenSomethingWrongError?()
            }
        } else {
            didHappenSomethingWrongError?()
        }
    }
    
}
