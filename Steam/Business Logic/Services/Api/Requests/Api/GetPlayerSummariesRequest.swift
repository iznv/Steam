//
//  GetPlayerSummariesRequest.swift
//  Steam
//
//  Created by Ivan Zinovyev on 20/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

extension ApiService {

    func getPlayerSummaries(steamId: String,
                            completion: @escaping (Result<SteamResponse<PlayerSummariesResponse>, Error>) -> Void) {
        
        let parameters: [RequestParameter: Any] = [
            .steamIds: steamId
        ]

        request(url: "ISteamUser/GetPlayerSummaries/v2",
                with: parameters,
                needApiKey: true,
                completion: completion)
    }

}
