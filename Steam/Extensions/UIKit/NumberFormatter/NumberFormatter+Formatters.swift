//
//  NumberFormatter+Formatters.swift
//  Steam
//
//  Created by Ivan Zinovyev on 24/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import Foundation

extension NumberFormatter {
    
    static let playedTime: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = .enUS
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 1
        return formatter
    }()
    
}
