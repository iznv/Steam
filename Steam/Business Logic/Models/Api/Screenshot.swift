//
//  Screenshot.swift
//  Steam
//
//  Created by Ivan Zinovyev on 23/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

struct Screenshot: Codable {
    
    let id: Int
    
    let pathThumbnail: String
    
    let pathFull: String
    
}

private extension Screenshot {
    
    enum CodingKeys: String, CodingKey {
        
        case id
        
        case pathThumbnail = "path_thumbnail"
        
        case pathFull = "path_full"
        
    }
    
}
