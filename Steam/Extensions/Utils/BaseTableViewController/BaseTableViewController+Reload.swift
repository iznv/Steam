//
//  BaseTableViewController+Reload.swift
//  Steam
//
//  Created by Ivan Zinovyev on 23/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import Utils

extension BaseTableViewController {
    
    func reload() {
        tableView.crossDissolveTransition { [weak self] in
            self?.configureTableView()
        }
    }
    
}
