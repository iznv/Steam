//
//  UISearchBar+TextColor.swift
//  Steam
//
//  Created by Ivan Zinovyev on 04/12/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import UIKit

extension UISearchBar {
    
    func setSearchField(textColor: UIColor,
                        backgroundColor: UIColor,
                        glassColor: UIColor,
                        clearButtonMode: UITextField.ViewMode = .never) {
        
        if let textField = self.value(forKey: "searchField") as? UITextField {
            textField.textColor = textColor
            textField.backgroundColor = backgroundColor
            
            if let glassIconView = textField.leftView as? UIImageView {
                glassIconView.image = glassIconView.image?.withRenderingMode(.alwaysTemplate)
                glassIconView.tintColor = glassColor
            }
            
            textField.clearButtonMode = clearButtonMode
        }
    }
    
}
