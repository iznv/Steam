//
//  NewsItem.swift
//  Steam
//
//  Created by Ivan Zinovyev on 22/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

public struct NewsItem: Codable {

    public let gid: String
    
    public let title: String
    
    public let url: String
    
    public let isExternalURL: Bool
    
    public let author: String
    
    public let contents: String
    
    public let feedLabel: String
    
    public let date: Int
    
    public let feedName: String
    
    public let feedType: Int
    
    public let appId: Int
    
    public let tags: [String]?

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
