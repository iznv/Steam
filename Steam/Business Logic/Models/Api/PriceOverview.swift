//
//  PriceOverview.swift
//  Steam
//
//  Created by Ivan Zinovyev on 23/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

struct PriceOverview: Codable {
    
    let finalFormatted: String

}

private extension PriceOverview {
    
    enum CodingKeys: String, CodingKey {
        
        case finalFormatted = "final_formatted"
        
    }
    
}
