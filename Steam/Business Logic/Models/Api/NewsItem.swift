//
//  NewsItem.swift
//  Steam
//
//  Created by Ivan Zinovyev on 22/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

struct NewsItem: Codable {

    let gid: String
    
    let title: String
    
    let url: String
    
    let isExternalURL: Bool
    
    let author: String
    
    let contents: String
    
    let feedLabel: String
    
    let date: Int
    
    let feedName: String
    
    let feedType: Int
    
    let appId: Int
    
    let tags: [String]?

}

private extension NewsItem {
    
    enum CodingKeys: String, CodingKey {
        
        case gid
        
        case title
        
        case url
        
        case isExternalURL = "is_external_url"
        
        case author
        
        case contents
        
        case feedLabel = "feedlabel"
        
        case date
        
        case feedName = "feedname"
        
        case feedType = "feed_type"
        
        case appId = "appid"
        
        case tags
        
    }
    
}
