//
//  GetGlobalAchievementPercentagesForAppRequest.swift
//  Steam
//
//  Created by Ivan Zinovyev on 22/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

public extension ApiService {

    func getGlobalAchievementPercentagesForApp(gameId: Int,
                                               completion: @escaping (Result<GlobalAchievementPercentagesForAppResponse, Error>) -> Void) {
        
        let parameters: [RequestParameter: Any] = [
            .gameId: gameId
        ]

        request(url: "ISteamUserStats/GetGlobalAchievementPercentagesForApp/v2",
                with: parameters,
                completion: completion)
    }

}
