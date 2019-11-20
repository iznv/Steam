//
//  PersonaState.swift
//  Steam
//
//  Created by Ivan Zinovyev on 20/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

enum PersonaState: Int, Codable {
    
    case offline = 0
    
    case online = 1
    
    case busy = 2
    
    case away = 3
    
    case snooze = 4
    
    case lookingToTrade = 5
    
    case lookingToPlay = 6
    
}
