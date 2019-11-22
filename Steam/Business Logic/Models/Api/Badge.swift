//
//  Badge.swift
//  Steam
//
//  Created by Ivan Zinovyev on 21/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

struct Badge: Codable {
    
    let badgeid: Int
    
    let level: Int
    
    let completionTime: Int
    
    let xp: Int
    
    let scarcity: Int
    
    let appid: Int?
    
    let communityitemid: String?
    
    let borderColor: Int?

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
