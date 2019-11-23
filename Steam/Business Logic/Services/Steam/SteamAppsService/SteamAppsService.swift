//
//  SteamAppsService.swift
//  Steam
//
//  Created by Ivan Zinovyev on 23/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

class SteamAppsService {
    
    func getAppList(completion: @escaping (Result<[App], ApiService.Error>) -> Void) {
        
        ApiService.shared.getAppList {
            completion($0.map { $0.appList.apps })
        }
    }

}
