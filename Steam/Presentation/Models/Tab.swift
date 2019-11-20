//
//  Tab.swift
//  Steam
//
//  Created by Ivan Zinovyev on 20/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import UIKit

class Tab {
    
    // MARK: - Properties
    
    let controller: UIViewController
    
    let title: String?
    
    let image: UIImage?
    
    let selectedImage: UIImage?
    
    
    // MARK: - Life Cycle
    
    init(controller: UIViewController,
         title: String? = nil,
         image: UIImage? = nil,
         selectedImage: UIImage? = nil) {
        
        self.controller = controller
        self.title = title
        self.image = image
        self.selectedImage = selectedImage
        
        controller.tabBarItem = UITabBarItem(title: title, image: image, selectedImage: selectedImage)
    }
    
}
