//
//  GetRecentlyPlayedGamesRequest.swift
//  Steam
//
//  Created by Ivan Zinovyev on 20/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

public extension ApiService {

    func getRecentlyPlayedGames(steamId: String,
                                completion: @escaping (Result<SteamResponse<RecentlyPlayedGamesResponse>, Error>) -> Void) {
        
        let parameters: [RequestParameter: Any] = [
            .steamId: steamId
        ]

        request(url: "IPlayerService/GetRecentlyPlayedGames/v1",
                with: parameters,
                needApiKey: true,
                completion: completion)
    }

}
