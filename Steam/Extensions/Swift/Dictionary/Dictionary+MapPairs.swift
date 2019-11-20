//
//  Dictionary+MapPairs.swift
//  Steam
//
//  Created by Ivan Zinovyev on 19/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import Foundation

extension Dictionary {

    init(_ pairs: [Element]) {
        self.init()
        pairs.forEach { key, value in self[key] = value }
    }

    func mapPairs<OutKey: Hashable, OutValue>(_ transform: (Element)
        throws -> (OutKey, OutValue))
        rethrows -> [OutKey: OutValue] {

            return [OutKey: OutValue](try map(transform))
    }

}
