//
//  BaseTableViewController.swift
//  Steam
//
//  Created by Ivan Zinovyev on 07.01.2023.
//  Copyright © 2023 Ivan Zinovev. All rights reserved.
//

import Utils

class BaseTableViewController<ViewModelType>: Utils.BaseTableViewController<ViewModelType> {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
    }

}
