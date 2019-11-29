//
//  ReleaseDate.swift
//  Steam
//
//  Created by Ivan Zinovyev on 23/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

public struct ReleaseDate: Codable {
    
    public let comingSoon: Bool
    
    public let date: String

}

private extension ReleaseDate {
    
    enum CodingKeys: String, CodingKey {
        
        case comingSoon = "coming_soon"
        
        case date
        
    }
    
}
