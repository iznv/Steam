//
//  TitleValueItem.swift
//  Steam
//
//  Created by Ivan Zinovyev on 23/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

struct TitleValueItem {
    
    // MARK: - Properties
    
    let title: String
    
    let value: String
    
    let action: (() -> Void)?
    
    // MARK: - Init
    
    init(title: String,
         value: String,
         action: (() -> Void)? = nil) {
        
        self.title = title
        self.value = value
        self.action = action
    }
    
}
