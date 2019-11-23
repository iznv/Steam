//
//  SteamStoreService.swift
//  Steam
//
//  Created by Ivan Zinovyev on 23/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

class SteamStoreService {
    
    func appDetails(appId: Int,
                    completion: @escaping (AppDetails?) -> Void) {
        
        ApiService.shared.appDetails(appId: appId) {
            if let response = $0[String(appId)],
               response.success {
                completion(response.data)
            } else {
                completion(nil)
            }
        }
    }
    
}
