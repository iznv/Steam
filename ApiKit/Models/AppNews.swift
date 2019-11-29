//
//  AppNews.swift
//  Steam
//
//  Created by Ivan Zinovyev on 22/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

public struct AppNews: Codable {
    
    public let appId: Int
    
    public let newsItems: [NewsItem]
    
    public let count: Int

}

private extension AppNews {
    
    enum CodingKeys: String, CodingKey {
        
        case appId = "appid"
        
        case newsItems = "newsitems"
        
        case count
    
    }

}
