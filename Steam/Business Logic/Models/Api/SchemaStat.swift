//
//  Stat.swift
//  Steam
//
//  Created by Ivan Zinovyev on 22/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

struct SchemaStat: Codable {
    
    let name: String
    
    let defaultValue: Int
    
    let displayName: String

}

private extension SchemaStat {
    
    enum CodingKeys: String, CodingKey {
        
        case name = "name"
        
        case defaultValue = "defaultvalue"
        
        case displayName

    }
    
}
