//
//  Stat.swift
//  Steam
//
//  Created by Ivan Zinovyev on 22/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

public struct Stat: Codable {
    
    public let name: String
    
    public let value: Double
    
}

public extension Array where Element == Stat {
    
    func value(for name: String) -> Double? {
        return first { $0.name == name }?.value
    }
    
}
