//
//  GetPlayerAchievementsRequest.swift
//  Steam
//
//  Created by Ivan Zinovyev on 22/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

extension ApiService {

    func getPlayerAchievements(steamId: String,
                               appId: Int,
                               completion: @escaping (PlayerAchievementsResponse) -> Void) {
        
        let parameters: [RequestParameter: Any] = [
            .steamId: steamId,
            .appId: appId
        ]

        request(url: "ISteamUserStats/GetPlayerAchievements/v1",
                with: parameters,
                needApiKey: true,
                completion: completion)
    }

}
