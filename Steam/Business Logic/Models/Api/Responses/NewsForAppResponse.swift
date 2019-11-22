//
//  NewsForAppResponse.swift
//  Steam
//
//  Created by Ivan Zinovyev on 22/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

struct NewsForAppResponse: Codable {
    
    let appNews: AppNews
    
}

private extension NewsForAppResponse {
    
    enum CodingKeys: String, CodingKey {
        
        case appNews = "appnews"
    
    }

}
