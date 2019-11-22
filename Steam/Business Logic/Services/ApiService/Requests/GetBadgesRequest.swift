//
//  GetBadgesRequest.swift
//  Steam
//
//  Created by Ivan Zinovyev on 21/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

extension ApiService {

    func getBadges(steamId: String,
                   completion: @escaping (SteamResponse<BadgesResponse>) -> Void) {
        
        let parameters: [RequestParameter: Any] = [
            .steamId: steamId
        ]

        request(url: "IPlayerService/GetBadges/v1",
                with: parameters,
                needApiKey: true,
                completion: completion)
    }

}
