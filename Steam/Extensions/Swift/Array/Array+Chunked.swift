//
//  Array+Chunked.swift
//  Steam
//
//  Created by Ivan Zinovyev on 24/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import Foundation

extension Array {
    
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, count)])
        }
    }

}
