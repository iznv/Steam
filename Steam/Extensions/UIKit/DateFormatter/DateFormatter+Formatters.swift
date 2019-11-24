//
//  DateFormatter+Formatters.swift
//  Steam
//
//  Created by Ivan Zinovyev on 23/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    static let common: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = .enUS
        formatter.dateFormat = "d MMM, yyyy"
        return formatter
    }()
    
}
