//
//  SteamNewsService.swift
//  Steam
//
//  Created by Ivan Zinovyev on 22/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import Foundation

class SteamNewsService {
    
    func getNewsForApp(appId: Int,
                       endDate: Int? = nil,
                       count: Int = 20,
                       completion: @escaping ([NewsItem]) -> Void) {
        
        ApiService.shared.getNewsForApp(appId: appId,
                                        endDate: endDate,
                                        count: count) {
            completion($0.appNews.newsItems)
        }
    }
    
}
