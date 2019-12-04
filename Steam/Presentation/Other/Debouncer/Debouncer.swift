//
//  Debouncer.swift
//  Steam
//
//  Created by Ivan Zinovyev on 04/12/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import Foundation

class Debouncer: NSObject {
    
    // MARK: - Properties
    
    private var callback: (() -> ())
    
    private var delay: Double
    
    private weak var timer: Timer?
    
    // MARK: - Init

    init(delay: Double,
         callback: @escaping (() -> ())) {
        
        self.delay = delay
        self.callback = callback
    }
    
    // MARK: - Public

    func call() {
        timer?.invalidate()
        
        let nextTimer = Timer.scheduledTimer(timeInterval: delay,
                                             target: self,
                                             selector: #selector(Debouncer.fireNow),
                                             userInfo: nil,
                                             repeats: false)
        
        timer = nextTimer
    }

}

// MARK: - Private

private extension Debouncer {
    
    @objc func fireNow() {
        callback()
    }
    
}
