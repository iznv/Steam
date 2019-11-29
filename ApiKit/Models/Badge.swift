//
//  Badge.swift
//  Steam
//
//  Created by Ivan Zinovyev on 21/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

public struct Badge: Codable {
    
    public let badgeid: Int
    
    public let level: Int
    
    public let completionTime: Int
    
    public let xp: Int
    
    public let scarcity: Int
    
    public let appid: Int?
    
    public let communityitemid: String?
    
    public let borderColor: Int?

}

private extension Badge {
    
    enum CodingKeys: String, CodingKey {
        
        case badgeid
        
        case level
        
        case completionTime = "completion_time"
        
        case xp
        
        case scarcity
        
        case appid
        
        case communityitemid
        
        case borderColor = "border_color"
    
    }
    
}
