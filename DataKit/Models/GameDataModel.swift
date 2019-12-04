//
//  GameDataModel.swift
//  DataKit
//
//  Created by Ivan Zinovyev on 04/12/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

public class GameDataModel {
    
    // MARK: - Properties
    
    public let appId: Int64
    
    public let name: String
    
    // MARK: - Init
    
    public init(appId: Int64,
                name: String) {
        
        self.appId = appId
        self.name = name
    }
    
}
