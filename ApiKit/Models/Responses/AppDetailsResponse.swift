//
//  AppDetailsResponse.swift
//  Steam
//
//  Created by Ivan Zinovyev on 23/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

public struct AppDetailsResponse: Codable {
    
    public let success: Bool
    
    public let data: AppDetails?
    
}
