//
//  Stat.swift
//  Steam
//
//  Created by Ivan Zinovyev on 22/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

public struct SchemaStat: Codable {
    
    public let name: String
    
    public let defaultValue: Int
    
    public let displayName: String

}

private extension SchemaStat {
    
    enum CodingKeys: String, CodingKey {
        
        case name = "name"
        
        case defaultValue = "defaultvalue"
        
        case displayName

    }
    
}

public extension SchemaStat {
    
    var title: String {
        return (displayName.isEmpty ? name : displayName)
            .replacingOccurrences(of: String.underscore, with: String.whitespace)
            .capitalized
    }
    
}
