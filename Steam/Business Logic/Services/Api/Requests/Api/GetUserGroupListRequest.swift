//
//  GetUserGroupListRequest.swift
//  Steam
//
//  Created by Ivan Zinovyev on 22/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

extension ApiService {

    func getUserGroupList(steamId: String,
                          completion: @escaping (Result<SteamResponse<UserGroupListResponse>, Error>) -> Void) {
        
        let parameters: [RequestParameter: Any] = [
            .steamId: steamId
        ]

        request(url: "ISteamUser/GetUserGroupList/v1",
                with: parameters,
                needApiKey: true,
                completion: completion)
    }

}
