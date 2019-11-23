//
//  AppListResponse.swift
//  Steam
//
//  Created by Ivan Zinovyev on 23/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

struct AppListResponse: Codable {
    
    let appList: AppList

}

private extension AppListResponse {
    
    enum CodingKeys: String, CodingKey {
        
        case appList = "applist"

    }
    
}
