//
//  GetNumberOfCurrentPlayersRequest.swift
//  Steam
//
//  Created by Ivan Zinovyev on 22/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

extension ApiService {

    func getNumberOfCurrentPlayers(appId: Int,
                                   completion: @escaping (Result<SteamResponse<NumberOfCurrentPlayersResponse>, Error>) -> Void) {
        
        let parameters: [RequestParameter: Any] = [
            .appId: appId
        ]

        request(url: "ISteamUserStats/GetNumberOfCurrentPlayers/v1",
                with: parameters,
                completion: completion)
    }

}
