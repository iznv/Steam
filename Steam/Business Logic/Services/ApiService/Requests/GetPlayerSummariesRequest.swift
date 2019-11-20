//
//  GetPlayerSummariesRequest.swift
//  Steam
//
//  Created by Ivan Zinovyev on 20/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

private enum Mocks {
    
    static let myId = "76561199004225368"
    
    static let somePersonId = "76561197960435530"
    
}

extension ApiService {

    func getPlayerSummaries(completion: @escaping (PlayerSummariesResponse) -> Void) {
        let parameters: [RequestParameter: Any] = [
            .steamIds: Mocks.myId
        ]

        request(url: "ISteamUser/GetPlayerSummaries/v2",
                with: parameters,
                needApiKey: true,
                completion: completion)
    }

}
