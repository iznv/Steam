//
//  AppDetailsRequest.swift
//  Steam
//
//  Created by Ivan Zinovyev on 23/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

extension ApiService {

    func appDetails(appId: Int,
                    completion: @escaping (Result<[String: AppDetailsResponse], Error>) -> Void) {
        
        let parameters: [RequestParameter: Any] = [
            .appIds: appId
        ]

        request(endpoint: .store,
                url: "api/appdetails",
                with: parameters,
                completion: completion)
    }

}
