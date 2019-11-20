//
//  Dictionary+Operators.swift
//  Steam
//
//  Created by Ivan Zinovyev on 19/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import Foundation

extension Dictionary {

    static func + (left: Dictionary,
                   right: Dictionary) -> Dictionary {

        var dictionary = left

        for (key, value) in right {
            dictionary[key] = value
        }

        return dictionary
    }

}
