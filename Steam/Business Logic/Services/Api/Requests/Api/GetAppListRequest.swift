//
//  GetAppListRequest.swift
//  Steam
//
//  Created by Ivan Zinovyev on 23/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

extension ApiService {

    func getAppList(completion: @escaping (AppListResponse) -> Void) {
        request(url: "ISteamApps/GetAppList/v2", completion: completion)
    }

}
