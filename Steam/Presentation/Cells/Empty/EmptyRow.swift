//
//  EmptyRow.swift
//  Steam
//
//  Created by Ivan Zinovyev on 27/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import TableKit

class EmptyRow: TableRow<EmptyCell> {
    
    // MARK: - Properties
    
    private let height: CGFloat
    
    private let color: UIColor
    
    // MARK: - Init
    
    init(height: CGFloat,
         color: UIColor = .clear) {
        
        self.height = height
        self.color = color
        
        super.init(item: ())
    }
    
    // MARK: - Overrides
    
    override var defaultHeight: CGFloat? {
        return height
    }
    
    override func configure(_ cell: UITableViewCell) {
        super.configure(cell)
        
        cell.backgroundColor = color
    }
    
}
