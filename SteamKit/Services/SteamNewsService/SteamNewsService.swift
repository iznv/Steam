//
//  SteamNewsService.swift
//  Steam
//
//  Created by Ivan Zinovyev on 22/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import ApiKit

public class SteamNewsService {
    
    public init() { }
    
}

public extension SteamNewsService {
    
    func getNewsForApp(appId: Int,
                       endDate: Int? = nil,
                       count: Int = 20,
                       completion: @escaping (Result<[NewsItem], ApiService.Error>) -> Void) {
        
        ApiService.shared.getNewsForApp(appId: appId,
                                        endDate: endDate,
                                        count: count) {
            completion($0.map { $0.appNews.newsItems })
        }
    }
    
}
