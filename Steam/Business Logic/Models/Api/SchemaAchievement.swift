//
//  Achievement.swift
//  Steam
//
//  Created by Ivan Zinovyev on 22/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

struct SchemaAchievement: Codable {
    
    let name: String
    
    let defaultValue: Int
    
    let displayName: String
    
    let hidden: Int
    
    let description: String
    
    let icon: String
    
    let iconGray: String

}

private extension SchemaAchievement {
    
    enum CodingKeys: String, CodingKey {
        
        case name
        
        case defaultValue = "defaultvalue"
        
        case displayName
        
        case hidden
        
        case description
        
        case icon
        
        case iconGray = "icongray"
        
    }
    
}
