//
//  GlobalAchievementPercentagesForAppResponse.swift
//  Steam
//
//  Created by Ivan Zinovyev on 22/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

public struct GlobalAchievementPercentagesForAppResponse: Codable {
    
    public let achievementPercentages: AchievementPercentages

}

private extension GlobalAchievementPercentagesForAppResponse {
    
    enum CodingKeys: String, CodingKey {
        
        case achievementPercentages = "achievementpercentages"

    }
    
}
