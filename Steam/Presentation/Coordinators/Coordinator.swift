//
//  Coordinator.swift
//  Steam
//
//  Created by Ivan Zinovyev on 30/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import UIKit

protocol Coordinator: class {
    
    var root: UIViewController { get }
    
    var didFinish: (() -> Void)? { get set }
    
    func start()
    
}

extension Coordinator {
    
    func makeBackButtonItem(shouldFinishOnTap: Bool) -> UIBarButtonItem {
        return BarButtonItem(image: R.image.backBarButton(), style: .plain) { [weak self] in
            guard let self = self else { return }
            
            (self.root as? UINavigationController)?.popViewController(animated: true)
            
            if shouldFinishOnTap {
                self.didFinish?()
            }
        }
    }
    
    func start(presenter: UIViewController,
               modalPresentationStyle: UIModalPresentationStyle = .fullScreen) {
        
        start()
        
        root.modalPresentationStyle = modalPresentationStyle
        presenter.present(root, animated: true, completion: nil)
    }
    
}
