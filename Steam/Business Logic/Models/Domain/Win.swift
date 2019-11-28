//
//  Win.swift
//  Steam
//
//  Created by Ivan Zinovyev on 29/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

enum Win {
    
    case first
    
    case second
    
    case draw
    
    case both
    
}

extension Win {
    
    static func compare(value1: Int,
                        value2: Int,
                        isDrawEqualsWinForBoth: Bool = false) -> Win {
        
        if value1 == value2 {
            return isDrawEqualsWinForBoth ? .both : .draw
        }
        
        if value1 > value2 {
            return .first
        }
        
        return .second
    }
    
}
