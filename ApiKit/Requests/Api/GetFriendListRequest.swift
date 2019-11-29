//
//  GetFriendListRequest.swift
//  Steam
//
//  Created by Ivan Zinovyev on 22/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

public extension ApiService {

    func getFriendList(steamId: String,
                       completion: @escaping (Result<FriendListResponse, Error>) -> Void) {
        
        let parameters: [RequestParameter: Any] = [
            .steamId: steamId
        ]

        request(url: "ISteamUser/GetFriendList/v1",
                with: parameters,
                needApiKey: true,
                completion: completion)
    }

}
