//
//  AppNews.swift
//  Steam
//
//  Created by Ivan Zinovyev on 22/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

struct AppNews: Codable {
    
    let appId: Int
    
    let newsItems: [NewsItem]
    
    let count: Int

}

private extension AppNews {
    
    enum CodingKeys: String, CodingKey {
        
        case appId = "appid"
        
        case newsItems = "newsitems"
        
        case count
    
    }

}
