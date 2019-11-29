//
//  GetUserStatsForGameRequest.swift
//  Steam
//
//  Created by Ivan Zinovyev on 22/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

public extension ApiService {

    func getUserStatsForGame(steamId: String,
                             appId: Int,
                             completion: @escaping (Result<UserStatsForGameResponse, Error>) -> Void) {
        
        let parameters: [RequestParameter: Any] = [
            .appId: appId,
            .steamId: steamId
        ]

        request(url: "ISteamUserStats/GetUserStatsForGame/v2",
                with: parameters,
                needApiKey: true,
                completion: completion)
    }

}
