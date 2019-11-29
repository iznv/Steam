//
//  StatDataModel.swift
//  Steam
//
//  Created by Ivan Zinovyev on 26/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import Foundation

public struct StatDataModel {
    
    // MARK: - Properties
    
    public let appId: Int64
    
    public let name: String
    
    public let value: Double
    
    public let date: Date
    
    // MARK: - Init
    
    public init(appId: Int64,
                name: String,
                value: Double,
                date: Date) {
        
        self.appId = appId
        self.name = name
        self.value = value
        self.date = date
    }
    
}
