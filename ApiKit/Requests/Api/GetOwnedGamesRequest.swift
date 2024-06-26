//
//  GetOwnedGamesRequest.swift
//  Steam
//
//  Created by Ivan Zinovyev on 20/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

public extension ApiService {

    func getOwnedGames(steamId: String,
                       includeFree: Bool = true,
                       completion: @escaping (Result<SteamResponse<OwnedGamesResponse>, Error>) -> Void) {
        
        let parameters: [RequestParameter: Any] = [
            .steamId: steamId,
            .includeAppInfo: true,
            .includePlayedFreeGames: includeFree
        ]

        request(url: "IPlayerService/GetOwnedGames/v1",
                with: parameters,
                needApiKey: true,
                completion: completion)
    }

}


