//
//  GetSteamLevelRequest.swift
//  Steam
//
//  Created by Ivan Zinovyev on 21/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

extension ApiService {

    func getSteamLevel(steamId: String,
                       completion: @escaping (SteamResponse<SteamLevelResponse>) -> Void) {
        
        let parameters: [RequestParameter: Any] = [
            .steamId: steamId
        ]

        request(url: "IPlayerService/GetSteamLevel/v1",
                with: parameters,
                needApiKey: true,
                completion: completion)
    }

}
