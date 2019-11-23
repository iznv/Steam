//
//  GetNewsForAppRequest.swift
//  Steam
//
//  Created by Ivan Zinovyev on 22/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

extension ApiService {

    func getNewsForApp(appId: Int,
                       endDate: Int?,
                       count: Int,
                       completion: @escaping (Result<NewsForAppResponse, Error>) -> Void) {
        
        var parameters: [RequestParameter: Any] = [
            .appId: appId,
            .count: count
        ]
        
        if let endDate = endDate {
            parameters[.endDate] = endDate
        }

        request(url: "ISteamNews/GetNewsForApp/v2",
                with: parameters,
                completion: completion)
    }

}
