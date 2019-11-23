//
//  GetSchemaForGameRequest.swift
//  Steam
//
//  Created by Ivan Zinovyev on 22/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

extension ApiService {

    func getSchemaForGame(appId: Int,
                          completion: @escaping (SchemaForGameResponse) -> Void) {
        
        let parameters: [RequestParameter: Any] = [
            .appId: appId
        ]

        request(url: "ISteamUserStats/GetSchemaForGame/v2",
                with: parameters,
                needApiKey: true,
                completion: completion)
    }

}
