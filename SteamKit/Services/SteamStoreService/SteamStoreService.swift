//
//  SteamStoreService.swift
//  Steam
//
//  Created by Ivan Zinovyev on 23/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import ApiKit

public class SteamStoreService {
    
    public init() { }
    
}

public extension SteamStoreService {
    
    func appDetails(appId: Int,
                    completion: @escaping (Result<AppDetails?, ApiService.Error>) -> Void) {
        
        ApiService.shared.appDetails(appId: appId) {
            if case let .success(data) = $0 {
                if let response = data[String(appId)], response.success {
                    completion($0.map { _ in response.data })
                } else {
                    completion($0.map { _ in nil })
                }
            } else {
                completion($0.map { _ in nil })
            }
        }
    }
    
}
