//
//  UISearchBar+TextColor.swift
//  Steam
//
//  Created by Ivan Zinovyev on 04/12/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import UIKit

extension UISearchBar {

    func setSearchField(textColor: UIColor) {
        
        if let textField = self.value(forKey: "searchField") as? UITextField {
            textField.textColor = textColor
        }
    }

}
