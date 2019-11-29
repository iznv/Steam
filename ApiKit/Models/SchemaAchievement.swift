//
//  Achievement.swift
//  Steam
//
//  Created by Ivan Zinovyev on 22/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

public struct SchemaAchievement: Codable {
    
    public let name: String
    
    public let defaultValue: Int
    
    public let displayName: String
    
    public let hidden: Int
    
    public let description: String?
    
    public let icon: String
    
    public let iconGray: String

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
