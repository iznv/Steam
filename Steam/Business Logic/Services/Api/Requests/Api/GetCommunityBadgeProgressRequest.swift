//
//  GetCommunityBadgeProgressRequest.swift
//  Steam
//
//  Created by Ivan Zinovyev on 21/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

extension ApiService {

    func getCommunityBadgeProgress(steamId: String,
                                   badgeId: Int,
                                   completion: @escaping (SteamResponse<CommunityBadgeProgressResponse>) -> Void) {
        
        let parameters: [RequestParameter: Any] = [
            .steamId: steamId,
            .badgeId: badgeId
        ]

        request(url: "IPlayerService/GetCommunityBadgeProgress/v1",
                with: parameters,
                needApiKey: true,
                completion: completion)
    }

}
