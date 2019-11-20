//
//  TableSection+Init.swift
//  Steam
//
//  Created by Ivan Zinovyev on 20/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import TableKit

extension TableSection {
    
    convenience init(onlyRows rows: [Row]) {
        self.init(rows: rows)
        
        self.headerView = nil
        self.headerHeight = .leastNonzeroMagnitude
        
        self.footerView = nil
        self.footerHeight = .leastNonzeroMagnitude
    }
    
}
