//
//  ReleaseDate.swift
//  Steam
//
//  Created by Ivan Zinovyev on 23/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

struct ReleaseDate: Codable {
    
    let comingSoon: Bool
    
    let date: String

}

private extension ReleaseDate {
    
    enum CodingKeys: String, CodingKey {
        
        case comingSoon = "coming_soon"
        
        case date
        
    }
    
}
