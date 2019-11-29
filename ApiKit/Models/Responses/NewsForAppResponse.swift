//
//  NewsForAppResponse.swift
//  Steam
//
//  Created by Ivan Zinovyev on 22/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

public struct NewsForAppResponse: Codable {
    
    public let appNews: AppNews
    
}

private extension NewsForAppResponse {
    
    enum CodingKeys: String, CodingKey {
        
        case appNews = "appnews"
    
    }

}
